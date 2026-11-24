<template>
  <div class="page-container">
    <div class="page-header">
      <div>
        <h2 class="page-title">文档管理</h2>
        <p class="page-sub">共 {{ total }} 份文档，支持搜索、分类与附件管理</p>
      </div>
      <el-button type="primary" @click="openDialog()">
        <el-icon><Plus /></el-icon> 新增文档
      </el-button>
    </div>

    <!-- 搜索栏 -->
    <el-card shadow="never" class="search-card">
      <el-form :inline="true" :model="query">
        <el-form-item label="文档名称">
          <el-input v-model="query.wendangmingcheng" placeholder="请输入文档名称" clearable style="width:200px" />
        </el-form-item>
        <el-form-item label="类型">
          <el-select v-model="query.leixing" placeholder="全部类型" clearable style="width:140px">
            <el-option v-for="t in typeOptions" :key="t" :label="t" :value="t" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">查询</el-button>
          <el-button @click="resetSearch">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <!-- 数据表格 -->
    <el-card shadow="never" style="margin-top:16px">
      <el-table :data="tableData" v-loading="loading" stripe border>
        <el-table-column prop="id" label="ID" width="90" />
        <el-table-column prop="wendangmingcheng" label="文档名称" min-width="150" />
        <el-table-column prop="leixing" label="类型" width="100">
          <template #default="{ row }"><el-tag size="small" effect="plain" :style="{ color: typeColor(row.leixing), borderColor: typeColor(row.leixing) + '55' }">{{ row.leixing }}</el-tag></template>
        </el-table-column>
        <el-table-column prop="xiangmu" label="项目" width="120" show-overflow-tooltip>
          <template #default="{ row }">
            <span v-if="row.xiangmu">{{ row.xiangmu }}</span>
            <span v-else style="color:#bfbfbf">未归属</span>
          </template>
        </el-table-column>
        <el-table-column prop="wendangjieshao" label="文档介绍" min-width="180" show-overflow-tooltip />
        <el-table-column prop="faburiqi" label="发布日期" width="120" />
        <el-table-column label="正文" width="90">
          <template #default="{ row }">
            <el-tag v-if="hasContent(row)" size="small" type="success" effect="light">在线正文</el-tag>
            <span v-else style="color:#bfbfbf">无</span>
          </template>
        </el-table-column>
        <el-table-column label="附件" width="90">
          <template #default="{ row }">
            <el-button v-if="row.fujian" link type="primary" size="small" @click="downloadFile(row.fujian)">下载</el-button>
            <span v-else style="color:#bfbfbf">无</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="200" fixed="right">
          <template #default="{ row }">
            <el-button link type="primary" size="small" @click="openDialog(row)">编辑</el-button>
            <el-button link type="success" size="small" @click="openContent(row)">正文</el-button>
            <el-button link type="danger" size="small" @click="handleDelete(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <div class="pagination">
        <el-pagination
          v-model:current-page="query.page"
          v-model:page-size="query.limit"
          :page-sizes="[5, 10, 20, 50]"
          :total="total"
          layout="total, sizes, prev, pager, next, jumper"
          @size-change="loadData"
          @current-change="loadData"
        />
      </div>
    </el-card>

    <!-- 新增/编辑弹窗 -->
    <el-dialog v-model="dialogVisible" :title="dialogTitle" width="560px" destroy-on-close>
      <el-form ref="formRef" :model="form" :rules="rules" label-width="90px">
        <el-form-item label="文档名称" prop="wendangmingcheng">
          <el-input v-model="form.wendangmingcheng" placeholder="请输入文档名称" />
        </el-form-item>
        <el-form-item label="类型" prop="leixing">
          <el-select v-model="form.leixing" placeholder="请选择类型" style="width:100%">
            <el-option v-for="t in typeOptions" :key="t" :label="t" :value="t" />
          </el-select>
        </el-form-item>
        <el-form-item label="所属项目">
          <el-select v-model="form.xiangmu" placeholder="归属项目（可输入新建）" style="width:100%"
            filterable allow-create clearable default-first-option>
            <el-option v-for="p in projectOptions" :key="p" :label="p" :value="p" />
          </el-select>
        </el-form-item>
        <el-form-item label="发布日期" prop="faburiqi">
          <el-date-picker v-model="form.faburiqi" type="date" value-format="YYYY-MM-DD" placeholder="选择日期" style="width:100%" />
        </el-form-item>
        <el-form-item label="文档介绍">
          <el-input v-model="form.wendangjieshao" type="textarea" :rows="3" placeholder="请输入文档介绍" />
        </el-form-item>
        <el-form-item label="附件">
          <el-upload
            class="upload-demo"
            action="/springbootpkh49/file/upload"
            :on-success="handleUploadSuccess"
            :on-error="handleUploadError"
            :show-file-list="false"
            accept=".doc,.docx,.pdf,.ppt,.pptx,.xls,.xlsx,.txt,.zip"
          >
            <el-button type="primary" plain><el-icon><Upload /></el-icon> 上传文件</el-button>
          </el-upload>
          <div v-if="form.fujian" class="file-name">
            已上传：{{ form.fujian.split('/').pop() }}
          </div>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" :loading="saving" @click="handleSave">确定</el-button>
      </template>
    </el-dialog>

    <!-- 正文编辑弹窗（富文本 / Markdown） -->
    <el-dialog v-model="contentVisible" :title="'编辑正文 · ' + contentRow.wendangmingcheng"
      width="860px" top="5vh" destroy-on-close>
      <MdEditor v-if="contentRow.leixing === 'Markdown'" v-model="contentHtml" style="height: 440px"
        :toolbarsExclude="['github', 'save', 'htmlPreview', 'catalog', 'mermaid']" :preview="false" />
      <RichEditor v-else v-model="contentHtml" height="420px" placeholder="撰写文档正文，保存后可在前台阅读页直接查看…" />
      <template #footer>
        <el-button @click="contentVisible = false">取消</el-button>
        <el-button type="primary" :loading="contentSaving" @click="saveContent">保存正文</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { MdEditor } from 'md-editor-v3'
import 'md-editor-v3/lib/style.css'
import { wendangApi, lishiApi, typeColor } from '@/api'
import RichEditor from '@/components/RichEditor.vue'

const loading = ref(false)
const saving = ref(false)
const tableData = ref([])
const total = ref(0)
const typeOptions = ['Word', 'PDF', 'PPT', 'Excel', '在线文档', 'Markdown', '其他']
const query = reactive({ page: 1, limit: 10, wendangmingcheng: '', leixing: '' })
const projectOptions = ref([])

const adminName = () => {
  try { return JSON.parse(localStorage.getItem('userInfo'))?.username || '管理员' } catch { return '管理员' }
}
// 历史快照（后台编辑人记管理员用户名）
function snapshot(doc, beizhu) {
  return lishiApi.save({
    wendangid: doc.id, wendangmingcheng: doc.wendangmingcheng, leixing: doc.leixing,
    neirong: doc.neirong || '', neirongmd: doc.neirongmd || '', xiangmu: doc.xiangmu || '',
    bianjiren: adminName(), beizhu
  }).catch(e => console.error('历史快照写入失败', e))
}
async function loadProjects() {
  const res = await wendangApi.page({ page: 1, limit: 1000 })
  const set = new Set()
  ;(res.data?.list || []).forEach(d => { const p = (d.xiangmu || '').trim(); if (p) set.add(p) })
  projectOptions.value = [...set]
}

// 正文编辑
const contentVisible = ref(false)
const contentSaving = ref(false)
const contentRow = ref({})
const contentHtml = ref('')

function hasContent(row) {
  const html = row.neirong || ''
  const md = (row.neirongmd || '').trim()
  return md.length > 0 || html.replace(/<[^>]+>/g, '').trim().length > 0 || /<img|<table/i.test(html)
}
function openContent(row) {
  contentRow.value = row
  contentHtml.value = row.leixing === 'Markdown' ? (row.neirongmd || '') : (row.neirong || '')
  if (contentHtml.value === ' ') contentHtml.value = ''
  contentVisible.value = true
}
async function saveContent() {
  contentSaving.value = true
  try {
    const isMd = contentRow.value.leixing === 'Markdown'
    // 传完整对象：xiangmu 为 IGNORED 策略，缺省会被置 null
    const payload = {
      ...contentRow.value,
      neirong: isMd ? ' ' : (contentHtml.value || ' '),
      neirongmd: isMd ? (contentHtml.value || ' ') : ' '
    }
    const res = await wendangApi.update(payload)
    if (res.code === 0) {
      await snapshot(payload, isMd ? '后台编辑 Markdown' : '后台编辑正文')
      ElMessage.success('正文已保存')
      contentVisible.value = false
      loadData()
    } else ElMessage.error(res.msg || '保存失败')
  } finally { contentSaving.value = false }
}

const dialogVisible = ref(false)
const dialogTitle = ref('新增文档')
const formRef = ref()
const form = reactive({ id: null, wendangmingcheng: '', leixing: '', xiangmu: null, wendangjieshao: '', fujian: '', faburiqi: '' })
const rules = {
  wendangmingcheng: [{ required: true, message: '请输入文档名称', trigger: 'blur' }],
  leixing: [{ required: true, message: '请选择类型', trigger: 'change' }]
}

async function loadData() {
  loading.value = true
  try {
    const params = { page: query.page, limit: query.limit }
    // 后端约定：字段名带 _like 后缀才是模糊匹配，名称搜索必须加，类型筛选保持精确匹配
    if (query.wendangmingcheng) params.wendangmingcheng_like = query.wendangmingcheng
    if (query.leixing) params.leixing = query.leixing
    const res = await wendangApi.page(params)
    tableData.value = res.data?.list || []
    total.value = res.data?.total || 0
  } finally {
    loading.value = false
  }
}

function handleSearch() { query.page = 1; loadData() }
function resetSearch() { query.wendangmingcheng = ''; query.leixing = ''; handleSearch() }

function openDialog(row) {
  if (row) {
    dialogTitle.value = '编辑文档'
    Object.assign(form, row)
  } else {
    dialogTitle.value = '新增文档'
    Object.assign(form, { id: null, wendangmingcheng: '', leixing: '', xiangmu: null, wendangjieshao: '', fujian: '', faburiqi: '' })
  }
  dialogVisible.value = true
}

async function handleSave() {
  await formRef.value.validate()
  saving.value = true
  try {
    const payload = { ...form, xiangmu: form.xiangmu || null }
    if (form.id) {
      await wendangApi.update(payload)
      await snapshot(payload, '后台编辑元数据')
      ElMessage.success('修改成功')
    } else {
      await wendangApi.save(payload)
      const q = await wendangApi.page({ page: 1, limit: 1, wendangmingcheng: payload.wendangmingcheng, sidx: 'id', order: 'DESC' })
      const created = q.data?.list?.[0]
      if (created) await snapshot(created, '后台新建文档')
      ElMessage.success('新增成功')
    }
    dialogVisible.value = false
    loadData()
    loadProjects()
  } finally {
    saving.value = false
  }
}

async function handleDelete(row) {
  await ElMessageBox.confirm(`确定删除「${row.wendangmingcheng}」吗？`, '提示', { type: 'warning' })
  await wendangApi.delete([row.id])
  ElMessage.success('删除成功')
  loadData()
}

function handleUploadSuccess(res) {
  if (res.code === 0) {
    form.fujian = `/springbootpkh49/upload/${res.file}`
    ElMessage.success('上传成功')
  } else {
    ElMessage.error('上传失败')
  }
}
function handleUploadError() { ElMessage.error('上传失败，请检查后端服务') }

function downloadFile(url) {
  window.open(url.startsWith('http') ? url : url, '_blank')
}

onMounted(() => { loadData(); loadProjects() })
</script>

<style scoped>
.page-sub { color: var(--text-3); font-size: 13px; margin: 4px 0 0; }
.search-card :deep(.el-form-item) { margin-bottom: 0; }
.pagination { display: flex; justify-content: flex-end; margin-top: 16px; }
.file-name { font-size: 12px; color: #18a058; margin-top: 6px; }
.card-type-tag :deep(.el-tag) { border-radius: 4px; }
</style>
