<template>
  <div class="page-container">
    <div class="page-header">
      <div>
        <h2 class="page-title">数据概览</h2>
        <p class="page-sub">欢迎回来，这里是平台运行概况</p>
      </div>
      <el-tag type="success" effect="plain" round><span class="dot"></span> 系统运行中</el-tag>
    </div>

    <!-- 统计卡片 -->
    <el-row :gutter="16">
      <el-col :span="6" v-for="stat in stats" :key="stat.label">
        <div class="stat-card">
          <div class="stat-icon" :style="{ background: stat.bg, color: stat.color }">
            <el-icon :size="22"><component :is="stat.icon" /></el-icon>
          </div>
          <div class="stat-body">
            <div class="stat-label">{{ stat.label }}</div>
            <div class="stat-value">{{ stat.value }}</div>
          </div>
          <div class="stat-trend" :style="{ color: stat.color }">
            <el-icon><TopRight /></el-icon> 实时
          </div>
        </div>
      </el-col>
    </el-row>

    <el-row :gutter="16" class="content-row">
      <el-col :span="16">
        <div class="panel">
          <div class="panel-head">
            <div class="panel-title"><span class="title-bar"></span>最近文档</div>
            <el-button link type="primary" @click="$router.push('/wendang')">查看全部 <el-icon><ArrowRight /></el-icon></el-button>
          </div>
          <el-table :data="recentDocs" size="small" v-loading="loading" class="recent-table">
            <el-table-column prop="wendangmingcheng" label="文档名称" min-width="180">
              <template #default="{ row }">
                <div class="doc-cell">
                  <el-icon :style="{ color: typeColor(row.leixing) }"><Document /></el-icon>
                  <span>{{ row.wendangmingcheng }}</span>
                </div>
              </template>
            </el-table-column>
            <el-table-column prop="leixing" label="类型" width="100">
              <template #default="{ row }">
                <el-tag size="small" effect="plain" :style="{ color: typeColor(row.leixing), borderColor: typeColor(row.leixing) + '55' }">{{ row.leixing }}</el-tag>
              </template>
            </el-table-column>
            <el-table-column prop="faburiqi" label="发布日期" width="120" />
          </el-table>
        </div>
      </el-col>

      <el-col :span="8">
        <div class="panel">
          <div class="panel-head"><div class="panel-title"><span class="title-bar"></span>快捷操作</div></div>
          <div class="quick-list">
            <div class="quick-item" @click="$router.push('/wendang')">
              <span class="q-icon" style="background:#e8f7f0;color:#00b96b"><el-icon><DocumentAdd /></el-icon></span>
              <span class="q-text"><strong>文档管理</strong><small>上传与维护文档资料</small></span>
              <el-icon class="q-arrow"><ArrowRight /></el-icon>
            </div>
            <div class="quick-item" @click="$router.push('/gonggao')">
              <span class="q-icon" style="background:#fff3e4;color:#e8912d"><el-icon><Bell /></el-icon></span>
              <span class="q-text"><strong>发布公告</strong><small>管理平台通知动态</small></span>
              <el-icon class="q-arrow"><ArrowRight /></el-icon>
            </div>
            <div class="quick-item" @click="$router.push('/yuangong')">
              <span class="q-icon" style="background:#e8f7ee;color:#18a058"><el-icon><User /></el-icon></span>
              <span class="q-text"><strong>员工信息</strong><small>查看组织成员档案</small></span>
              <el-icon class="q-arrow"><ArrowRight /></el-icon>
            </div>
            <div class="quick-item" @click="goFront">
              <span class="q-icon" style="background:#e6fffb;color:#08979c"><el-icon><View /></el-icon></span>
              <span class="q-text"><strong>查看前台</strong><small>预览用户端门户</small></span>
              <el-icon class="q-arrow"><ArrowRight /></el-icon>
            </div>
          </div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { wendangApi, bumenApi, yuangongApi, gonggaoApi, typeColor } from '@/api'

const router = useRouter()
const loading = ref(false)
const recentDocs = ref([])
const stats = ref([
  { label: '文档总数', value: 0, icon: 'Document', color: '#00b96b', bg: '#e8f7f0' },
  { label: '部门数量', value: 0, icon: 'OfficeBuilding', color: '#18a058', bg: '#e8f7ee' },
  { label: '员工数量', value: 0, icon: 'User', color: '#e8912d', bg: '#fff3e4' },
  { label: '公告数量', value: 0, icon: 'Bell', color: '#08979c', bg: '#e6fffb' }
])

function goFront() { window.open('http://localhost:5174', '_blank') }

async function loadData() {
  loading.value = true
  try {
    const [docRes, deptRes, empRes, noticeRes] = await Promise.all([
      wendangApi.page({ page: 1, limit: 5, sidx: 'addtime', order: 'DESC' }),
      bumenApi.page({ page: 1, limit: 1 }),
      yuangongApi.page({ page: 1, limit: 1 }),
      gonggaoApi.page({ page: 1, limit: 1 })
    ])
    stats.value[0].value = docRes.data?.total || 0
    stats.value[1].value = deptRes.data?.total || 0
    stats.value[2].value = empRes.data?.total || 0
    stats.value[3].value = noticeRes.data?.total || 0
    recentDocs.value = docRes.data?.list || []
  } catch (e) {
    console.error('加载概览数据失败', e)
  } finally {
    loading.value = false
  }
}

onMounted(loadData)
</script>

<style scoped>
.page-sub { color: var(--text-3); font-size: 13px; margin: 4px 0 0; }
.dot { display: inline-block; width: 6px; height: 6px; border-radius: 50%; background: #18a058; margin-right: 6px; vertical-align: middle; }

.stat-card {
  background: #fff; border: 1px solid var(--border); border-radius: var(--radius-m);
  padding: 20px; display: flex; align-items: center; gap: 14px; position: relative;
  transition: all .2s;
}
.stat-card:hover { box-shadow: var(--shadow-2); transform: translateY(-2px); }
.stat-icon { width: 46px; height: 46px; border-radius: 11px; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
.stat-label { font-size: 12px; color: var(--text-3); margin-bottom: 4px; }
.stat-value { font-size: 26px; font-weight: 600; line-height: 1; }
.stat-trend { position: absolute; right: 16px; top: 16px; font-size: 11px; display: flex; align-items: center; gap: 2px; }

.content-row { margin-top: 16px; }
.panel { background: #fff; border: 1px solid var(--border); border-radius: var(--radius-m); overflow: hidden; }
.panel-head {
  height: 52px; padding: 0 20px; display: flex; align-items: center; justify-content: space-between;
  border-bottom: 1px solid var(--border-light);
}
.panel-title { display: flex; align-items: center; gap: 9px; font-size: 15px; font-weight: 600; }
.title-bar { width: 3px; height: 15px; border-radius: 2px; background: var(--brand); }
.doc-cell { display: flex; align-items: center; gap: 8px; }

.quick-list { padding: 8px 12px; }
.quick-item { display: flex; align-items: center; gap: 12px; padding: 12px 8px; border-radius: var(--radius-s); cursor: pointer; transition: background .15s; }
.quick-item:hover { background: var(--bg-hover); }
.q-icon { width: 38px; height: 38px; border-radius: 9px; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
.q-text { flex: 1; display: flex; flex-direction: column; gap: 2px; }
.q-text strong { font-size: 13px; font-weight: 600; }
.q-text small { font-size: 11px; color: var(--text-3); }
.q-arrow { color: var(--text-4); }
</style>
