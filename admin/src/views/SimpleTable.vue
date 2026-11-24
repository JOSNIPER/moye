<template>
  <div class="page-container">
    <div class="page-header">
      <div>
        <h2 class="page-title">{{ config.title }}</h2>
        <p class="page-sub">共 {{ total }} 条记录</p>
      </div>
      <el-button type="primary" @click="openDialog()"><el-icon><Plus /></el-icon> 新增</el-button>
    </div>

    <el-card shadow="never">
      <el-table :data="tableData" v-loading="loading" stripe border>
        <el-table-column v-for="col in config.columns" :key="col.prop"
          :prop="col.prop" :label="col.label" :width="col.width" :min-width="col.minWidth"
          show-overflow-tooltip>
          <template v-if="col.type === 'richtext'" #default="{ row }">
            {{ plainText(row[col.prop]) }}
          </template>
        </el-table-column>
        <el-table-column label="操作" width="150" fixed="right" v-if="config.editable !== false">
          <template #default="{ row }">
            <el-button link type="primary" size="small" @click="openDialog(row)">编辑</el-button>
            <el-button link type="danger" size="small" @click="handleDelete(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <div class="pagination">
        <el-pagination
          v-model:current-page="query.page" v-model:page-size="query.limit"
          :page-sizes="[10, 20, 50]" :total="total"
          layout="total, sizes, prev, pager, next, jumper"
          @size-change="loadData" @current-change="loadData" />
      </div>
    </el-card>

    <el-dialog v-model="dialogVisible" :title="dialogTitle" :width="hasRichtext ? '820px' : '500px'" destroy-on-close>
      <el-form ref="formRef" :model="form" :rules="rules" :label-width="hasRichtext ? '80px' : '90px'">
        <el-form-item v-for="col in config.columns.filter(c => c.prop !== 'id' && c.prop !== 'addtime')"
          :key="col.prop" :label="col.label" :prop="col.prop">
          <RichEditor v-if="col.type === 'richtext'" v-model="form[col.prop]" height="300px" />
          <el-date-picker v-else-if="col.type === 'date'" v-model="form[col.prop]" type="date"
            value-format="YYYY-MM-DD" placeholder="选择日期" style="width:100%" />
          <el-input-number v-else-if="col.type === 'number'" v-model="form[col.prop]" :min="0" style="width:100%" />
          <el-input v-else v-model="form[col.prop]" :placeholder="'请输入' + col.label" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" :loading="saving" @click="handleSave">确定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted, watch } from 'vue'
import { useRoute } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { bumenApi, gangweiApi, gonggaoApi, yuangongApi, usersApi } from '@/api'
import RichEditor from '@/components/RichEditor.vue'

const route = useRoute()
const loading = ref(false)
const saving = ref(false)
const tableData = ref([])
const total = ref(0)
const query = reactive({ page: 1, limit: 10 })
const dialogVisible = ref(false)
const dialogTitle = ref('')
const formRef = ref()
const form = reactive({})
const rules = {}

// 每张表的列配置 + 对应 API
const configs = {
  '/bumen': {
    title: '部门管理', api: bumenApi,
    columns: [
      { prop: 'id', label: 'ID', width: 90 },
      { prop: 'bumen', label: '部门名称', minWidth: 140 },
      { prop: 'renshu', label: '人数', width: 100, type: 'number' },
      { prop: 'renyuanjiagou', label: '人员架构', minWidth: 200 },
      { prop: 'addtime', label: '创建时间', width: 170 }
    ]
  },
  '/gangwei': {
    title: '岗位管理', api: gangweiApi,
    columns: [
      { prop: 'id', label: 'ID', width: 90 },
      { prop: 'gangwei', label: '岗位名称', minWidth: 160 },
      { prop: 'addtime', label: '创建时间', width: 170 }
    ]
  },
  '/gonggao': {
    title: '公告管理', api: gonggaoApi,
    columns: [
      { prop: 'id', label: 'ID', width: 90 },
      { prop: 'gonggaobiaoti', label: '公告标题', minWidth: 180 },
      { prop: 'neirong', label: '内容', minWidth: 220, type: 'richtext' },
      { prop: 'faburiqi', label: '发布日期', width: 120, type: 'date' },
      { prop: 'addtime', label: '创建时间', width: 170 }
    ]
  },
  '/yuangong': {
    title: '员工管理', api: yuangongApi,
    columns: [
      { prop: 'id', label: 'ID', width: 90 },
      { prop: 'yuangonggonghao', label: '工号', width: 120 },
      { prop: 'yuangongxingming', label: '姓名', width: 110 },
      { prop: 'xingbie', label: '性别', width: 80 },
      { prop: 'bumen', label: '部门', width: 120 },
      { prop: 'gangwei', label: '岗位', width: 120 },
      { prop: 'shouji', label: '手机', width: 130 },
      { prop: 'addtime', label: '创建时间', width: 170 }
    ]
  },
  '/users': {
    title: '账号管理', api: usersApi,
    columns: [
      { prop: 'id', label: 'ID', width: 90 },
      { prop: 'username', label: '用户名', minWidth: 140 },
      { prop: 'role', label: '角色', width: 120 },
      { prop: 'addtime', label: '创建时间', width: 170 }
    ]
  }
}

const config = computed(() => configs[route.path] || configs['/bumen'])
const hasRichtext = computed(() => config.value.columns.some(c => c.type === 'richtext'))

function plainText(html) {
  if (!html) return ''
  const div = document.createElement('div')
  div.innerHTML = html
  return (div.textContent || '').trim()
}

async function loadData() {
  loading.value = true
  try {
    const res = await config.value.api.page({ page: query.page, limit: query.limit })
    tableData.value = res.data?.list || []
    total.value = res.data?.total || 0
  } finally {
    loading.value = false
  }
}

function openDialog(row) {
  Object.keys(form).forEach(k => delete form[k])
  if (row) {
    dialogTitle.value = '编辑'
    Object.assign(form, row)
  } else {
    dialogTitle.value = '新增'
  }
  dialogVisible.value = true
}

async function handleSave() {
  saving.value = true
  try {
    if (form.id) {
      await config.value.api.update(form)
      ElMessage.success('修改成功')
    } else {
      await config.value.api.save(form)
      ElMessage.success('新增成功')
    }
    dialogVisible.value = false
    loadData()
  } finally {
    saving.value = false
  }
}

async function handleDelete(row) {
  await ElMessageBox.confirm(`确定删除这条记录吗？`, '提示', { type: 'warning' })
  await config.value.api.delete([row.id])
  ElMessage.success('删除成功')
  loadData()
}

watch(() => route.path, () => { query.page = 1; loadData() })
onMounted(loadData)
</script>

<style scoped>
.page-sub { color: var(--text-3); font-size: 13px; margin: 4px 0 0; }
.pagination { display: flex; justify-content: flex-end; margin-top: 16px; }
</style>
