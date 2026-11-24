<template>
  <div class="reader-page" v-loading="loading">
    <template v-if="doc">
      <!-- 顶部操作条 -->
      <div class="reader-bar">
        <el-button link class="back-btn" @click="goBack">
          <el-icon><ArrowLeft /></el-icon> 返回文档中心
        </el-button>
        <div class="bar-actions">
          <button class="pill-btn ghost" @click="historyVisible = true; loadHistory()">
            <el-icon><Clock /></el-icon> 历史版本
          </button>
          <button v-if="isMd" class="pill-btn ghost" @click="downloadMd">
            <el-icon><Download /></el-icon> 下载 .md
          </button>
          <button v-if="doc.fujian" class="pill-btn ghost" @click="download">
            <el-icon><Download /></el-icon> 下载附件
          </button>
          <button class="pill-btn" @click="$router.push('/workbench/edit/' + doc.id)">
            <el-icon><EditPen /></el-icon> 编辑 <span class="pill-arrow">→</span>
          </button>
        </div>
      </div>

      <!-- 文档纸张 -->
      <article class="paper reveal">
        <header class="paper-head">
          <div class="paper-type">
            <span class="type-dot" :style="{ background: typeColor(doc.leixing) }"></span>
            {{ doc.leixing || '其他' }} 文档
            <span v-if="doc.xiangmu" class="project-chip"><el-icon><Folder /></el-icon> {{ doc.xiangmu }}</span>
          </div>
          <h1 class="paper-title">{{ doc.wendangmingcheng }}</h1>
          <div class="paper-meta">
            <span>发布于 {{ doc.faburiqi || doc.addtime?.slice(0, 10) || '-' }}</span>
            <span class="meta-sep">·</span>
            <span>更新于 {{ doc.addtime || '-' }}</span>
          </div>
          <p class="paper-intro" v-if="doc.wendangjieshao">{{ doc.wendangjieshao }}</p>
        </header>

        <div class="paper-divider"></div>

        <!-- 正文：Markdown 渲染 / 富文本 -->
        <MdPreview v-if="isMd && hasMd" :modelValue="doc.neirongmd" editorId="reader-md" :theme="settings.theme" class="md-preview" />
        <div v-else-if="hasContent" class="rich-content" v-html="doc.neirong"></div>

        <!-- 无正文：附件型文档 -->
        <div v-else class="no-content">
          <el-icon :size="40" color="#bfbfbf"><Document /></el-icon>
          <p class="no-content-title">这是一份附件型文档</p>
          <p class="no-content-desc">正文尚未在线撰写，可下载附件查看，或点击「编辑」为它补充在线正文。</p>
          <div class="attach-box" v-if="doc.fujian">
            <el-icon :size="20" color="#00b96b"><Paperclip /></el-icon>
            <span class="attach-name text-ellipsis">{{ fileName(doc.fujian) }}</span>
            <el-button link type="primary" @click="download">下载</el-button>
          </div>
        </div>
      </article>
    </template>

    <el-empty v-if="!loading && !doc" description="文档不存在或已被删除">
      <el-button type="primary" @click="goBack">返回文档中心</el-button>
    </el-empty>

    <!-- 历史版本抽屉 -->
    <el-drawer v-model="historyVisible" title="历史版本" size="460px">
      <div class="history-tip">每次保存自动记录快照，单篇保留最近 50 版。点击版本可预览或恢复。</div>
      <div v-loading="historyLoading" class="history-list">
        <div v-for="(v, i) in versions" :key="v.id" class="history-item" @click="previewVersion(v)">
          <div class="history-main">
            <div class="history-title">
              <span class="history-index">v{{ versions.length - i }}</span>
              {{ v.beizhu || '编辑保存' }}
              <el-tag v-if="i === 0" size="small" type="success" effect="light">最新</el-tag>
            </div>
            <div class="history-meta">{{ v.bianjiren || '访客' }} · {{ v.addtime }}</div>
          </div>
          <el-button link type="primary" size="small" @click.stop="restoreVersion(v)">恢复</el-button>
        </div>
        <el-empty v-if="!historyLoading && !versions.length" description="暂无历史版本" :image-size="60" />
      </div>
    </el-drawer>

    <!-- 版本预览弹窗 -->
    <el-dialog v-model="previewVisible" :title="'版本预览 · ' + (previewRow.addtime || '')" width="760px" top="6vh">
      <div class="preview-meta">{{ previewRow.bianjiren }} · {{ previewRow.beizhu }}</div>
      <MdPreview v-if="previewRow.leixing === 'Markdown' && (previewRow.neirongmd || '').trim()"
        :modelValue="previewRow.neirongmd" editorId="version-md" :theme="settings.theme" />
      <div v-else class="rich-content preview-body" v-html="previewRow.neirong || '<p>（空正文）</p>'"></div>
      <template #footer>
        <el-button @click="previewVisible = false">关闭</el-button>
        <el-button type="primary" @click="restoreVersion(previewRow)">恢复此版本</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, computed, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { MdPreview } from 'md-editor-v3'
import 'md-editor-v3/lib/style.css'
import { wendangApi, lishiApi, saveHistory, typeColor } from '@/api'
import { useReveal } from '@/composables/useReveal'
import { settings } from '@/composables/useSettings'

const { refresh } = useReveal()
const route = useRoute()
const router = useRouter()
const loading = ref(false)
const doc = ref(null)

const isMd = computed(() => doc.value?.leixing === 'Markdown')
const hasMd = computed(() => (doc.value?.neirongmd || '').trim().length > 0)
const hasContent = computed(() => {
  const html = doc.value?.neirong || ''
  return html.replace(/<[^>]+>/g, '').trim().length > 0 || /<img|<table/i.test(html)
})

// 历史版本
const historyVisible = ref(false)
const historyLoading = ref(false)
const versions = ref([])
const previewVisible = ref(false)
const previewRow = ref({})

function fileName(url) {
  try { return decodeURIComponent(url.split('/').pop()) } catch { return url.split('/').pop() }
}
function download() { if (doc.value?.fujian) window.open(doc.value.fujian, '_blank') }
function downloadMd() {
  const blob = new Blob([doc.value.neirongmd || ''], { type: 'text/markdown;charset=utf-8' })
  const a = document.createElement('a')
  a.href = URL.createObjectURL(blob)
  a.download = (doc.value.wendangmingcheng || 'document') + '.md'
  a.click()
  URL.revokeObjectURL(a.href)
}
function goBack() { router.push('/workbench/docs') }

async function loadHistory() {
  historyLoading.value = true
  try {
    const res = await lishiApi.page({ wendangid: route.params.id, page: 1, limit: 50 })
    versions.value = res.data?.list || []
  } finally { historyLoading.value = false }
}
function previewVersion(v) { previewRow.value = v; previewVisible.value = true }
async function restoreVersion(v) {
  try {
    await ElMessageBox.confirm(`恢复到 ${v.addtime} 的版本？当前内容会先记入历史。`, '恢复版本', { type: 'warning' })
  } catch { return }
  // 当前内容先快照
  await saveHistory(doc.value, { beizhu: '恢复前自动快照' })
  const payload = {
    ...doc.value,
    neirong: v.neirong || ' ',
    neirongmd: v.neirongmd || ' ',
    leixing: v.leixing || doc.value.leixing,
    xiangmu: v.xiangmu || null
  }
  const res = await wendangApi.update(payload)
  if (res.code === 0) {
    await saveHistory(payload, { beizhu: `恢复自 ${v.addtime}` })
    ElMessage.success('已恢复')
    previewVisible.value = false
    historyVisible.value = false
    load(route.params.id)
  } else ElMessage.error(res.msg || '恢复失败')
}

async function load(id) {
  loading.value = true
  doc.value = null
  try {
    const res = await wendangApi.detail(id)
    if (res.code === 0) doc.value = res.data
    refresh()
  } finally { loading.value = false }
}

watch(() => route.params.id, (id) => { if (id) load(id) }, { immediate: true })
</script>

<style scoped>
.reader-page { max-width: 860px; margin: 0 auto; }

.reader-bar { display: flex; align-items: center; justify-content: space-between; margin-bottom: 16px; gap: 12px; flex-wrap: wrap; }
.back-btn { color: var(--text-2); font-size: 13px; }
.bar-actions { display: flex; gap: 8px; flex-wrap: wrap; }

.paper {
  background: var(--bg-card); border: 1px solid var(--border); border-radius: 18px;
  padding: 56px 64px 72px; box-shadow: 0 18px 60px rgba(0, 60, 35, .06);
}
.paper-head { margin-bottom: 8px; }
.paper-type { display: flex; align-items: center; gap: 6px; font-size: 12px; color: var(--text-3); margin-bottom: 14px; }
.type-dot { width: 8px; height: 8px; border-radius: 50%; }
.project-chip {
  display: inline-flex; align-items: center; gap: 4px; margin-left: 8px;
  color: #00996b; background: var(--mint); padding: 3px 12px; border-radius: var(--radius-pill); font-size: 11px;
}
.paper-title { font-size: 34px; font-weight: 800; line-height: 1.3; margin: 0 0 14px; letter-spacing: -.5px; color: var(--ink); }
.paper-meta { font-size: 13px; color: var(--text-3); display: flex; gap: 8px; }
.meta-sep { color: var(--text-4); }
.paper-intro {
  margin: 18px 0 0; padding: 12px 16px; font-size: 13px; line-height: 1.7;
  color: var(--text-2); background: var(--mint-2); border-left: 3px solid var(--brand);
  border-radius: 0 10px 10px 0;
}
.paper-divider { border-top: 1px solid var(--border-light); margin: 28px 0 32px; }

.md-preview { background: transparent; }
.md-preview :deep(.md-editor-preview-wrapper) { padding: 0; }
.md-preview :deep(.md-editor-preview) { font-size: 15px; line-height: 1.9; color: var(--text-1); }

.no-content { text-align: center; padding: 40px 0 20px; }
.no-content-title { font-size: 15px; font-weight: 600; margin: 14px 0 6px; }
.no-content-desc { font-size: 13px; color: var(--text-3); margin: 0 0 20px; }
.attach-box {
  display: inline-flex; align-items: center; gap: 10px; max-width: 420px;
  padding: 10px 16px; border: 1px solid var(--border); border-radius: var(--radius-m);
}
.attach-name { font-size: 13px; max-width: 280px; }

.history-tip { font-size: 12px; color: var(--text-3); margin-bottom: 14px; line-height: 1.7; }
.history-item {
  display: flex; align-items: center; gap: 10px; padding: 12px 14px;
  border: 1px solid #ececec; border-radius: 12px;
  margin-bottom: 8px; cursor: pointer; transition: transform .2s ease, box-shadow .2s ease;
}
.history-item:hover { transform: translateY(-2px); box-shadow: var(--shadow-lift); }
.history-main { flex: 1; min-width: 0; }
.history-title { font-size: 13px; font-weight: 600; display: flex; align-items: center; gap: 8px; }
.history-index { color: var(--text-4); font-weight: 500; font-size: 11px; }
.history-meta { font-size: 11px; color: var(--text-3); margin-top: 4px; }

.preview-meta { font-size: 12px; color: var(--text-3); margin-bottom: 12px; }
.preview-body { max-height: 60vh; overflow-y: auto; }

@media (max-width: 900px) {
  .paper { padding: 32px 24px 48px; }
  .paper-title { font-size: 24px; }
}
</style>