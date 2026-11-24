<template>
  <div class="editor-page" @dragenter="onDragEnter" @dragleave="onDragLeave" @dragover="onDragOver" @drop="onDrop">
    <!-- 拖拽导入遮罩 -->
    <div v-if="dragging" class="drop-overlay">
      <div class="drop-box">
        <el-icon :size="40"><Upload /></el-icon>
        <p>松开导入文件</p>
        <span>.md 直接成为在线 Markdown 文档，其他格式成为附件文档</span>
      </div>
    </div>

    <!-- 顶部操作条 -->
    <div class="editor-bar">
      <el-button link class="back-btn" @click="goBack">
        <el-icon><ArrowLeft /></el-icon> 取消
      </el-button>
      <div class="bar-title">{{ isEdit ? '编辑文档' : '新建文档' }}</div>
      <div class="bar-actions">
        <button class="pill-btn ghost" @click="mdInput.click()">
          <el-icon><Upload /></el-icon> 导入 .md
        </button>
        <input ref="mdInput" type="file" accept=".md,.markdown" style="display:none" @change="onMdPick" />
        <button v-if="isEdit" class="pill-btn danger-ghost" @click="handleDelete">删除</button>
        <button class="pill-btn" :disabled="saving" @click="handleSave">
          <el-icon><Check /></el-icon> 保存
        </button>
      </div>
    </div>

    <div class="editor-paper reveal" v-loading="loading">
      <!-- 标题 -->
      <input v-model="form.wendangmingcheng" class="title-input" placeholder="无标题文档" maxlength="100" />

      <!-- 元信息 -->
      <div class="meta-row">
        <div class="meta-item">
          <span class="meta-label">类型</span>
          <el-select v-model="form.leixing" style="width: 130px" size="small">
            <el-option v-for="t in ['在线文档', 'Markdown', 'Word', 'PPT', 'Excel', 'PDF']" :key="t" :label="t" :value="t" />
          </el-select>
        </div>
        <div class="meta-item">
          <span class="meta-label">项目</span>
          <el-select v-model="form.xiangmu" style="width: 160px" size="small" filterable allow-create
            clearable default-first-option placeholder="归属项目（可新建）">
            <el-option v-for="p in projectOptions" :key="p" :label="p" :value="p" />
          </el-select>
        </div>
        <div class="meta-item">
          <span class="meta-label">发布日期</span>
          <el-date-picker v-model="form.faburiqi" type="date" value-format="YYYY-MM-DD"
            size="small" style="width: 150px" placeholder="选择日期" />
        </div>
        <div class="meta-item meta-upload">
          <span class="meta-label">附件</span>
          <el-upload :action="UPLOAD_URL" :headers="uploadHeaders" name="file" :show-file-list="false"
            :on-success="onUploadSuccess" :on-error="onUploadError" :before-upload="beforeUpload">
            <el-button size="small" plain>
              <el-icon><Upload /></el-icon> {{ form.fujian ? '重新上传' : '上传附件' }}
            </el-button>
          </el-upload>
          <span v-if="form.fujian" class="attach-chip text-ellipsis">
            <el-icon><Paperclip /></el-icon> {{ fileName(form.fujian) }}
            <el-icon class="chip-close" @click="form.fujian = ''"><Close /></el-icon>
          </span>
        </div>
      </div>

      <!-- 简介 -->
      <el-input v-model="form.wendangjieshao" type="textarea" :rows="2" maxlength="300"
        placeholder="一句话介绍这份文档（可选）" class="intro-input" resize="none" />

      <!-- 正文：Markdown 模式 / 富文本模式 -->
      <MdEditor v-if="isMd" v-model="form.neirongmd" class="body-editor md-editor" :theme="settings.theme"
        :toolbarsExclude="['github', 'save', 'htmlPreview', 'catalog', 'mermaid']"
        :preview="false" placeholder="开始书写 Markdown…" @onUploadImg="onUploadImg" />
      <RichEditor v-else v-model="form.neirong" height="460px" class="body-editor" />
      <div class="editor-tip">
        {{ isMd ? 'Markdown 模式：支持标准语法与实时工具栏，阅读页渲染预览，可下载 .md 源文件。' : '正文支持标题、列表、引用、图片、表格等富文本格式，保存后可在阅读页直接查看。' }}
        每次保存都会记录历史版本。<span class="wb-caret"></span>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, computed, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { MdEditor } from 'md-editor-v3'
import 'md-editor-v3/lib/style.css'
import RichEditor from '@/components/RichEditor.vue'
import { wendangApi, saveHistory, uploadFile, UPLOAD_URL, fileUrl } from '@/api'
import { useDropImport } from '@/composables/dropImport'
import { useReveal } from '@/composables/useReveal'
import { settings } from '@/composables/useSettings'

useReveal()
const route = useRoute()
const router = useRouter()
const loading = ref(false)
const saving = ref(false)
const mdInput = ref()
const projectOptions = ref([])

const isEdit = computed(() => !!route.params.id)
const isMd = computed(() => form.leixing === 'Markdown')
const uploadHeaders = computed(() => ({ Token: localStorage.getItem('front_token') || '' }))

const emptyForm = () => ({
  id: null,
  wendangmingcheng: '',
  leixing: '在线文档',
  xiangmu: null,
  wendangjieshao: '',
  neirong: '',
  neirongmd: '',
  fujian: '',
  faburiqi: new Date().toISOString().slice(0, 10)
})
const form = reactive(emptyForm())

const { dragging, importFiles, onDragEnter, onDragLeave, onDragOver, onDrop } = useDropImport((ok) => {
  if (ok && !isEdit.value) router.push('/workbench/docs')
})

function fileName(url) {
  try { return decodeURIComponent(url.split('/').pop()) } catch { return url.split('/').pop() }
}
function goBack() {
  if (isEdit.value) router.push('/workbench/doc/' + route.params.id)
  else router.push('/workbench/docs')
}

// 导入 .md：编辑态载入当前表单，新建态直接建文档
async function onMdPick(e) {
  const file = e.target.files?.[0]
  e.target.value = ''
  if (!file) return
  const text = await file.text()
  if (isEdit.value) {
    form.neirongmd = text
    form.leixing = 'Markdown'
    if (!form.wendangmingcheng) form.wendangmingcheng = file.name.replace(/\.[^.]+$/, '')
    ElMessage.success('已载入 Markdown 内容，保存后生效')
  } else {
    await importFiles([file])
  }
}

// Markdown 编辑器图片上传
async function onUploadImg(files, callback) {
  try {
    const urls = await Promise.all(files.map(f => uploadFile(f)))
    callback(urls)
  } catch (e) { ElMessage.error('图片上传失败：' + e.message) }
}

function beforeUpload(file) {
  if (file.size > 10 * 1024 * 1024) { ElMessage.warning('附件不能超过 10MB'); return false }
  return true
}
function onUploadSuccess(res) {
  if (res.code === 0 && res.file) {
    form.fujian = fileUrl(res.file)
    ElMessage.success('附件上传成功')
  } else ElMessage.error(res.msg || '上传失败')
}
function onUploadError() { ElMessage.error('上传失败，请确认后端已启动') }

async function handleSave() {
  if (!form.wendangmingcheng.trim()) { ElMessage.warning('请填写文档标题'); return }
  saving.value = true
  try {
    // 空正文用空格占位（后端非空策略会跳过空串），两种正文互斥清理
    const payload = {
      ...form,
      wendangmingcheng: form.wendangmingcheng.trim(),
      fujian: form.fujian || '',
      xiangmu: form.xiangmu || null,
      neirong: isMd.value ? ' ' : (form.neirong || '<p><br></p>'),
      neirongmd: isMd.value ? (form.neirongmd || ' ') : ' '
    }
    let res
    if (isEdit.value) {
      res = await wendangApi.update(payload)
    } else {
      delete payload.id
      res = await wendangApi.add(payload)
    }
    if (res.code === 0) {
      // 历史快照：新建时回查 id
      let snap = payload
      if (!isEdit.value) {
        const q = await wendangApi.page({ page: 1, limit: 1, wendangmingcheng: payload.wendangmingcheng, sidx: 'id', order: 'DESC' })
        snap = q.data?.list?.[0] || payload
      }
      await saveHistory(snap, { beizhu: isEdit.value ? '编辑保存' : '新建文档' })
      ElMessage.success('保存成功')
      if (isEdit.value) router.push('/workbench/doc/' + form.id)
      else router.push('/workbench/docs')
    } else ElMessage.error(res.msg || '保存失败')
  } finally { saving.value = false }
}

async function handleDelete() {
  try {
    await ElMessageBox.confirm('删除后不可恢复，确定删除这份文档吗？', '删除文档', { type: 'warning', confirmButtonText: '删除', cancelButtonText: '取消' })
  } catch { return }
  const res = await wendangApi.remove([form.id])
  if (res.code === 0) { ElMessage.success('已删除'); router.push('/workbench/docs') }
  else ElMessage.error(res.msg || '删除失败')
}

async function loadProjects() {
  try {
    const res = await wendangApi.page({ page: 1, limit: 1000 })
    const set = new Set()
    ;(res.data?.list || []).forEach(d => { const p = (d.xiangmu || '').trim(); if (p) set.add(p) })
    projectOptions.value = [...set]
  } catch (e) { console.error(e) }
}

async function load(id) {
  loading.value = true
  Object.assign(form, emptyForm())
  try {
    const res = await wendangApi.detail(id)
    if (res.code === 0 && res.data) {
      Object.keys(form).forEach(k => { if (res.data[k] != null) form[k] = res.data[k] })
      if (form.neirongmd === ' ') form.neirongmd = ''
    } else ElMessage.error('文档不存在')
  } finally { loading.value = false }
}

watch(() => route.params.id, (id) => {
  if (id) load(id)
  else Object.assign(form, emptyForm())
}, { immediate: true })

loadProjects()
</script>

<style scoped>
.editor-page { max-width: 920px; margin: 0 auto; position: relative; }

.drop-overlay {
  position: fixed; inset: 0; z-index: 300; background: var(--overlay-bg);
  backdrop-filter: blur(2px); display: flex; align-items: center; justify-content: center;
}
.drop-box {
  border: 2px dashed var(--brand); border-radius: 18px; padding: 48px 64px;
  text-align: center; color: #00996b; background: var(--mint-grad);
}
.drop-box p { font-size: 20px; font-weight: 800; margin: 12px 0 6px; color: var(--ink); }
.drop-box span { font-size: 12px; color: var(--text-3); }

.editor-bar { display: flex; align-items: center; justify-content: space-between; margin-bottom: 16px; }
.back-btn { color: var(--text-2); font-size: 13px; }
.bar-title { font-size: 14px; font-weight: 600; color: var(--text-2); }
.bar-actions { display: flex; gap: 8px; }

.editor-paper {
  background: var(--bg-card); border: 1px solid var(--border); border-radius: 18px;
  padding: 40px 48px 32px; box-shadow: 0 18px 60px rgba(0, 60, 35, .06);
}
.title-input {
  width: 100%; border: none; outline: none; font-size: 32px; font-weight: 800; letter-spacing: -.5px;
  color: var(--ink); padding: 0 0 16px; border-bottom: 1px solid var(--border-light);
  background: transparent;
}
.title-input::placeholder { color: var(--text-4); }

.meta-row { display: flex; flex-wrap: wrap; gap: 20px; align-items: center; padding: 16px 0; }
.meta-item { display: flex; align-items: center; gap: 8px; }
.meta-label { font-size: 12px; color: var(--text-3); }
.meta-upload { flex: 1; min-width: 240px; }
.attach-chip {
  display: inline-flex; align-items: center; gap: 5px; font-size: 12px; color: var(--text-2);
  background: var(--bg-subtle); border: 1px solid var(--border-light);
  padding: 3px 8px; border-radius: 4px; max-width: 260px;
}
.chip-close { cursor: pointer; color: var(--text-3); }
.chip-close:hover { color: #e5484d; }

.intro-input { margin-bottom: 16px; }
.intro-input :deep(.el-textarea__inner) { background: var(--bg-subtle); box-shadow: none; border: 1px solid var(--border-light); font-size: 13px; }

.body-editor { margin-bottom: 10px; }
.md-editor { height: 480px; border-radius: var(--radius-m); }
.md-editor :deep(.md-editor-toolbar-wrapper) { background: var(--bg-subtle); }
.editor-tip { font-size: 12px; color: var(--text-4); }

@media (max-width: 900px) {
  .editor-paper { padding: 24px 20px; }
  .title-input { font-size: 22px; }
}
</style>