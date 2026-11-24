<template>
  <div class="docs-page" @dragenter="onDragEnter" @dragleave="onDragLeave" @dragover="onDragOver" @drop="onDrop">
    <!-- 拖拽导入遮罩 -->
    <div v-if="dragging" class="drop-overlay">
      <div class="drop-box">
        <el-icon :size="40"><Upload /></el-icon>
        <p>松开导入文件</p>
        <span>.md 直接成为在线 Markdown 文档，其他格式成为附件文档</span>
      </div>
    </div>

    <!-- 页头 -->
    <div class="page-head reveal">
      <div>
        <h2 class="wb-title">{{ currentTypeName }}</h2>
        <p class="wb-sub">共 {{ total }} 份文档 · 点击打开阅读 · 支持拖拽文件导入</p>
      </div>
      <div class="head-actions">
        <button class="pill-btn ghost" @click="fileInput.click()">
          <el-icon><Upload /></el-icon> 导入文档
        </button>
        <input ref="fileInput" type="file" multiple style="display:none" @change="onFilePick" />
        <button class="pill-btn" @click="$router.push('/workbench/new')">
          <el-icon><Plus /></el-icon> 新建文档
        </button>
        <div class="view-switch">
          <el-radio-group v-model="viewMode" size="small">
            <el-radio-button value="card"><el-icon><Grid /></el-icon></el-radio-button>
            <el-radio-button value="list"><el-icon><List /></el-icon></el-radio-button>
          </el-radio-group>
        </div>
      </div>
    </div>

    <!-- 工具栏 -->
    <div class="toolbar">
      <el-input v-model="keyword" placeholder="搜索文档名称、介绍…" clearable class="toolbar-search"
        @keyup.enter="handleSearch" @clear="handleSearch">
        <template #prefix><el-icon><Search /></el-icon></template>
      </el-input>
      <el-select v-model="sortField" style="width:150px" @change="handleSearch">
        <el-option label="创建时间" value="addtime" />
        <el-option label="发布日期" value="faburiqi" />
        <el-option label="文档名称" value="wendangmingcheng" />
      </el-select>
      <el-tooltip :content="ascending ? '升序' : '降序'" placement="top">
        <el-button :icon="ascending ? 'Sort' : 'SortDown'" @click="toggleOrder" />
      </el-tooltip>
      <div class="toolbar-spacer"></div>
      <el-button v-if="hasFilter" link type="primary" @click="clearAll">清除筛选</el-button>
    </div>

    <!-- 卡片视图 -->
    <div v-if="viewMode === 'card'" class="card-grid" v-loading="loading">
      <div v-for="(doc, i) in docs" :key="doc.id" class="doc-card wb-card reveal"
        :style="{ '--rd': (i % 4) * 70 + 'ms' }" @click="openDetail(doc)">
        <div class="card-top">
          <div class="card-file-icon" :style="{ background: typeColor(doc.leixing) + '14', color: typeColor(doc.leixing) }">
            <el-icon :size="26"><Document /></el-icon>
          </div>
          <el-tag size="small" effect="plain" class="card-type"
            :style="{ borderColor: typeColor(doc.leixing) + '55', color: typeColor(doc.leixing) }">
            {{ doc.leixing || '其他' }}
          </el-tag>
        </div>
        <div class="card-title text-ellipsis" v-html="highlight(doc.wendangmingcheng)"></div>
        <div class="card-desc" v-html="highlight(doc.wendangjieshao || '暂无介绍')"></div>
        <div class="card-bottom">
          <span class="card-date"><el-icon><Calendar /></el-icon> {{ doc.faburiqi || doc.addtime?.slice(0,10) }}</span>
          <span v-if="doc.xiangmu" class="card-project text-ellipsis"><el-icon><Folder /></el-icon> {{ doc.xiangmu }}</span>
          <el-button v-if="doc.fujian" link type="primary" size="small" @click.stop="download(doc)">
            <el-icon><Download /></el-icon> 下载
          </el-button>
        </div>
      </div>
      <el-empty v-if="!loading && !docs.length" description="没有找到匹配的文档" :image-size="90" class="grid-empty" />
    </div>

    <!-- 列表视图 -->
    <div v-else class="list-panel" v-loading="loading">
      <el-table :data="docs" stripe style="width:100%" @row-click="openDetail" class="doc-table">
        <el-table-column label="文档名称" min-width="260">
          <template #default="{ row }">
            <div class="list-name-cell">
              <el-icon :size="18" :style="{ color: typeColor(row.leixing) }"><Document /></el-icon>
              <span v-html="highlight(row.wendangmingcheng)"></span>
            </div>
          </template>
        </el-table-column>
        <el-table-column prop="leixing" label="类型" width="110">
          <template #default="{ row }">
            <el-tag size="small" effect="plain" :style="{ borderColor: typeColor(row.leixing) + '55', color: typeColor(row.leixing) }">
              {{ row.leixing || '其他' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="wendangjieshao" label="介绍" min-width="240" show-overflow-tooltip />
        <el-table-column prop="faburiqi" label="发布日期" width="130" />
        <el-table-column label="操作" width="140">
          <template #default="{ row }">
            <el-button link type="primary" size="small" @click.stop="openDetail(row)">阅读</el-button>
            <el-button v-if="row.fujian" link type="primary" size="small" @click.stop="download(row)">下载</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <!-- 分页 -->
    <div class="pagination" v-if="total > query.limit">
      <el-pagination v-model:current-page="query.page" v-model:page-size="query.limit"
        :page-sizes="[12, 24, 48]" :total="total" layout="total, sizes, prev, pager, next"
        background @size-change="loadData" @current-change="loadData" />
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { wendangApi, typeColor } from '@/api'
import { useDropImport } from '@/composables/dropImport'
import { useReveal } from '@/composables/useReveal'
import { settings } from '@/composables/useSettings'

const route = useRoute()
const router = useRouter()
const { refresh } = useReveal()
const loading = ref(false)
const docs = ref([])
const total = ref(0)
const viewMode = ref(settings.defaultView === 'list' ? 'list' : 'card')
const keyword = ref('')
const sortField = ref('addtime')
const ascending = ref(false)
const query = reactive({ page: 1, limit: 12 })
const fileInput = ref()

const { dragging, importFiles, onDragEnter, onDragLeave, onDragOver, onDrop } = useDropImport(() => loadData())
function onFilePick(e) {
  const files = e.target.files
  e.target.value = ''
  if (files?.length) importFiles(files)
}

const typeNames = { Word: 'Word 文档', PPT: 'PPT 演示', Excel: 'Excel 表格', PDF: 'PDF 文件', Markdown: 'Markdown 文档', 在线文档: '在线文档' }
const currentTypeName = computed(() =>
  route.query.xiangmu ? `项目 · ${route.query.xiangmu}` : (typeNames[route.query.type] || '全部文档'))
const hasFilter = computed(() => !!(keyword.value || route.query.type || route.query.q || route.query.xiangmu))

function highlight(text) {
  const kw = keyword.value.trim()
  if (!kw || !text) return text
  const esc = s => String(s).replace(/[&<>"']/g, c => ({ '&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;' }[c]))
  return esc(text).split(esc(kw)).join(`<mark>${esc(kw)}</mark>`)
}

async function loadData() {
  loading.value = true
  try {
    const params = { page: query.page, limit: query.limit, sidx: sortField.value, order: ascending.value ? 'ASC' : 'DESC' }
    if (keyword.value) params.wendangmingcheng_like = keyword.value
    if (route.query.type) params.leixing = route.query.type
    if (route.query.xiangmu) params.xiangmu = route.query.xiangmu
    const res = await wendangApi.page(params)
    docs.value = res.data?.list || []
    total.value = res.data?.total || 0
    refresh()
  } finally { loading.value = false }
}

function handleSearch() { query.page = 1; loadData() }
function toggleOrder() { ascending.value = !ascending.value; handleSearch() }
function clearAll() {
  keyword.value = ''
  router.push('/workbench/docs')
}
function openDetail(doc) { router.push('/workbench/doc/' + doc.id) }
function download(doc) { window.open(doc.fujian, '_blank') }

// 侧栏分类 / 顶栏搜索 → URL query 变化时同步筛选
watch(() => route.query, (q) => {
  keyword.value = q.q || ''
  query.page = 1
  loadData()
}, { immediate: true })

onMounted(() => { keyword.value = route.query.q || '' })
</script>

<style scoped>
.docs-page { max-width: 1360px; margin: 0 auto; }
.page-head { display: flex; align-items: flex-start; justify-content: space-between; margin-bottom: 22px; }

.toolbar {
  display: flex; align-items: center; gap: 12px; background: var(--bg-card);
  border: 1px solid var(--border); border-radius: 12px;
  padding: 12px 16px; margin-bottom: 20px;
}
.toolbar-search { width: 320px; max-width: 45vw; }
.toolbar-search :deep(.el-input__wrapper) { background: var(--bg-page); box-shadow: none; border-radius: var(--radius-pill); }
.toolbar-spacer { flex: 1; }

.card-grid {
  display: grid; grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  gap: 16px; min-height: 200px;
}
.grid-empty { grid-column: 1 / -1; }
.doc-card { padding: 18px; cursor: pointer; position: relative; }
/* reveal 入场带 stagger；入场完成后 hover 上浮恢复灵敏 */
.doc-card.reveal { transition: opacity .7s ease var(--rd, 0s), transform .7s ease var(--rd, 0s); }
.doc-card.reveal.in { transition: transform .25s ease, box-shadow .25s ease; }
.card-top { display: flex; align-items: flex-start; justify-content: space-between; margin-bottom: 14px; }
.card-file-icon { width: 48px; height: 48px; border-radius: 12px; display: flex; align-items: center; justify-content: center; }
.card-type { border-style: solid; border-radius: var(--radius-pill); }
.card-title { font-size: 15px; font-weight: 600; margin-bottom: 8px; }
.card-desc {
  font-size: 12px; color: var(--text-3); line-height: 1.6; height: 38px;
  overflow: hidden; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; margin-bottom: 14px;
}
.card-bottom {
  display: flex; align-items: center; justify-content: space-between;
  padding-top: 12px; border-top: 1px solid var(--border-light);
}
.card-date { display: flex; align-items: center; gap: 5px; font-size: 11px; color: var(--text-3); }

.list-panel { background: var(--bg-card); border: 1px solid var(--border); border-radius: var(--radius-card); overflow: hidden; }
.doc-table { cursor: pointer; }
.list-name-cell { display: flex; align-items: center; gap: 8px; }
.pagination { display: flex; justify-content: flex-end; margin-top: 20px; }

:deep(mark) { background: #fff0c2; color: #b26a00; padding: 0 2px; border-radius: 2px; }

.head-actions { display: flex; align-items: center; gap: 12px; }

.drop-overlay {
  position: fixed; inset: 0; z-index: 300; background: var(--overlay-bg);
  backdrop-filter: blur(3px); display: flex; align-items: center; justify-content: center;
}
.drop-box {
  position: relative; border: 2px dashed var(--brand); border-radius: 18px; padding: 48px 64px;
  text-align: center; color: #00996b; overflow: hidden;
  background: var(--mint-grad);
}
.drop-box::before {
  content: ''; position: absolute; inset: 0; pointer-events: none;
  background-image: linear-gradient(var(--grid-line) 1px, transparent 1px), linear-gradient(90deg, var(--grid-line) 1px, transparent 1px);
  background-size: 44px 44px;
}
.drop-box > * { position: relative; }
.drop-box p { font-size: 20px; font-weight: 800; margin: 12px 0 6px; color: var(--ink); }
.drop-box span { font-size: 12px; color: var(--text-3); }

.card-project {
  display: inline-flex; align-items: center; gap: 4px; font-size: 11px;
  color: #00996b; background: var(--mint); padding: 2px 10px; border-radius: var(--radius-pill); max-width: 110px;
}

@media (max-width: 900px) {
  .toolbar { flex-wrap: wrap; }
  .toolbar-search { width: 100%; max-width: none; }
  .page-head { flex-wrap: wrap; gap: 12px; }
}
</style>
