<template>
  <div class="workbench">
    <!-- 顶部产品栏 -->
    <header class="topbar">
      <div class="topbar-left">
        <div class="logo" @click="$router.push('/')" title="返回官网首页">
          <img :src="'/favicon.svg'" alt="墨页 Logo" class="logo-mark" />
          <span class="logo-text">墨页</span>
        </div>
        <span class="topbar-divider"></span>
        <span class="topbar-label">文档工作台</span>
      </div>

      <div class="topbar-center">
        <el-input v-model="globalSearch" placeholder="搜索文档名称、介绍…" class="global-search"
          clearable @keyup.enter="doSearch">
          <template #prefix><el-icon><Search /></el-icon></template>
          <template #suffix><span class="search-kbd">Enter</span></template>
        </el-input>
      </div>

      <div class="topbar-right">
        <button class="pill-btn" @click="$router.push('/workbench/new')">
          <el-icon><Plus /></el-icon> 新建文档
        </button>
        <a class="topbar-link" @click="$router.push('/')">
          <el-icon><House /></el-icon> 返回官网
        </a>
        <el-popover placement="bottom-end" :width="252" trigger="click" popper-class="settings-popper">
          <template #reference>
            <el-button class="icon-btn" circle title="偏好设置"><el-icon :size="18"><Setting /></el-icon></el-button>
          </template>
          <div class="settings-menu">
            <div class="set-title">偏好设置</div>
            <div class="set-row">
              <span class="set-label"><el-icon><Sunny /></el-icon> 外观模式</span>
              <div class="seg">
                <button :class="{ on: settings.theme === 'light' }" @click="settings.theme = 'light'">亮色</button>
                <button :class="{ on: settings.theme === 'dark' }" @click="settings.theme = 'dark'">暗色</button>
              </div>
            </div>
            <div class="set-row">
              <span class="set-label"><el-icon><MagicStick /></el-icon> 减少动效</span>
              <el-switch v-model="settings.reduceMotion" size="small" />
            </div>
            <div class="set-row">
              <span class="set-label"><el-icon><Grid /></el-icon> 默认视图</span>
              <div class="seg">
                <button :class="{ on: settings.defaultView === 'card' }" @click="settings.defaultView = 'card'">卡片</button>
                <button :class="{ on: settings.defaultView === 'list' }" @click="settings.defaultView = 'list'">列表</button>
              </div>
            </div>
            <div class="set-divider"></div>
            <button class="pill-btn ghost set-admin" @click="goAdmin">
              <el-icon><Monitor /></el-icon> 进入后台 <span class="pill-arrow">→</span>
            </button>
          </div>
        </el-popover>
        <div class="avatar" title="访客用户">访</div>
      </div>
    </header>

    <div class="body-wrap">
      <!-- 左侧分类导航 -->
      <aside class="sidebar">
        <div class="side-section">
          <div class="side-group-title">工作区</div>
          <div class="side-item" :class="{ active: route.path === '/workbench' }" @click="$router.push('/workbench')">
            <el-icon><DataBoard /></el-icon><span>概览</span>
          </div>
          <div class="side-item" :class="{ active: route.path === '/workbench/docs' && !route.query.type && !route.query.xiangmu }" @click="$router.push('/workbench/docs')">
            <el-icon><Folder /></el-icon><span>全部文档</span>
            <span class="side-count">{{ total }}</span>
          </div>
          <div class="side-item" :class="{ active: route.path === '/workbench/notices' }" @click="$router.push('/workbench/notices')">
            <el-icon><Bell /></el-icon><span>公告通知</span>
          </div>
        </div>

        <div class="side-section">
          <div class="side-group-title">文档分类</div>
          <div v-for="t in typeTabs" :key="t.value"
            class="side-item"
            :class="{ active: route.path === '/workbench/docs' && route.query.type === t.value }"
            @click="$router.push('/workbench/docs?type=' + t.value)">
            <el-icon :style="{ color: t.color }"><component :is="t.icon" /></el-icon>
            <span>{{ t.label }}</span>
            <span class="side-count">{{ t.count }}</span>
          </div>
        </div>

        <div class="side-section" v-if="projectTabs.length">
          <div class="side-group-title">项目分类</div>
          <div v-for="p in projectTabs" :key="p.name"
            class="side-item"
            :class="{ active: route.path === '/workbench/docs' && route.query.xiangmu === p.name }"
            @click="$router.push('/workbench/docs?xiangmu=' + encodeURIComponent(p.name))">
            <el-icon color="#00b96b"><Folder /></el-icon>
            <span class="text-ellipsis">{{ p.name }}</span>
            <span class="side-count">{{ p.count }}</span>
          </div>
        </div>

        <div class="side-footer">
          <div class="side-promo mint-panel">
            <div class="side-promo-title"><span class="dot"></span> 拖拽即导入</div>
            <p>把 .md 或 Office 文件拖进文档中心，自动建档并记录首版历史。</p>
          </div>
        </div>
      </aside>

      <!-- 主内容区 -->
      <main class="main-content">
        <router-view />
      </main>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { wendangApi } from '@/api'
import { settings } from '@/composables/useSettings'

const route = useRoute()
const router = useRouter()
const globalSearch = ref('')
const total = ref(0)
const typeCounts = ref({})
const projectCounts = ref({})

const typeTabs = computed(() => {
  const defs = [
    { label: '在线文档', value: '在线文档', icon: 'EditPen', color: '#00b96b' },
    { label: 'Markdown', value: 'Markdown', icon: 'Memo', color: '#595959' },
    { label: 'Word 文档', value: 'Word', icon: 'Document', color: '#2b579a' },
    { label: 'PPT 演示', value: 'PPT', icon: 'DataBoard', color: '#c43e1c' },
    { label: 'Excel 表格', value: 'Excel', icon: 'Grid', color: '#217346' },
    { label: 'PDF 文件', value: 'PDF', icon: 'Files', color: '#e5484d' }
  ]
  return defs.filter(d => (typeCounts.value[d.value] || 0) > 0)
    .map(d => ({ ...d, count: typeCounts.value[d.value] || 0 }))
})

const projectTabs = computed(() =>
  Object.entries(projectCounts.value).map(([name, count]) => ({ name, count }))
    .sort((a, b) => b.count - a.count))

async function loadStats() {
  try {
    // 用 page 接口拿全量（limit=1000），list 接口默认只返回 10 条导致统计不准
    const res = await wendangApi.page({ page: 1, limit: 1000 })
    const all = res.data?.list || []
    total.value = res.data?.total || all.length
    const counts = {}
    const projects = {}
    all.forEach(d => {
      const k = d.leixing || '其他'; counts[k] = (counts[k] || 0) + 1
      const p = (d.xiangmu || '').trim(); if (p) projects[p] = (projects[p] || 0) + 1
    })
    typeCounts.value = counts
    projectCounts.value = projects
  } catch (e) { console.error('统计失败', e) }
}

function doSearch() {
  const q = globalSearch.value.trim()
  router.push(q ? '/workbench/docs?q=' + encodeURIComponent(q) : '/workbench/docs')
}
function goAdmin() { window.open('http://localhost:5173', '_blank') }

onMounted(loadStats)
// 新建/编辑/删除后回到列表等页面时刷新分类计数，避免角标过期
watch(() => route.path, loadStats)
</script>

<style scoped>
.workbench { min-height: 100vh; background: var(--bg-page); }

/* 顶部栏 */
.topbar {
  height: var(--header-h); background: var(--topbar-bg); backdrop-filter: blur(10px);
  border-bottom: 1px solid var(--border-light);
  display: flex; align-items: center; justify-content: space-between;
  padding: 0 24px; position: sticky; top: 0; z-index: 100;
}
.topbar-left, .topbar-right { display: flex; align-items: center; gap: 12px; flex: 1; }
.topbar-right { justify-content: flex-end; }
.topbar-center { width: 420px; max-width: 34vw; }

.logo { display: flex; align-items: center; gap: 9px; cursor: pointer; }
.logo-mark {
  width: 30px; height: 30px; border-radius: 7px;
}
.logo-text { font-size: 17px; font-weight: 700; letter-spacing: .5px; color: var(--text-1); white-space: nowrap; }
.topbar-divider { width: 1px; height: 20px; background: var(--border); margin-left: 6px; }
.topbar-label { color: var(--text-3); font-size: 13px; white-space: nowrap; }

.global-search :deep(.el-input__wrapper) { background: var(--bg-page); box-shadow: none; border-radius: 8px; }
.global-search :deep(.el-input__inner) { font-size: 13px; }
.search-kbd {
  font-size: 10px; color: var(--text-3); border: 1px solid var(--border);
  border-radius: 4px; padding: 1px 5px; background: var(--bg-card);
}
.icon-btn { color: var(--text-2); }
.topbar-link {
  position: relative; display: inline-flex; align-items: center; gap: 5px;
  color: var(--text-2); font-size: 13px; cursor: pointer; padding: 6px 0; text-decoration: none; white-space: nowrap;
}
.topbar-link::after { content: ''; position: absolute; left: 0; right: 100%; bottom: 0; height: 2px; background: var(--brand); transition: right .25s ease; }
.topbar-link:hover { color: var(--ink); }
.topbar-link:hover::after { right: 0; }
.avatar {
  width: 32px; height: 32px; border-radius: 50%; background: var(--brand-soft);
  color: var(--brand); font-size: 13px; font-weight: 600;
  display: flex; align-items: center; justify-content: center;
}

/* 左侧栏 */
.body-wrap { display: flex; min-height: calc(100vh - var(--header-h)); }
.sidebar {
  width: var(--sidebar-w); flex-shrink: 0; background: var(--bg-card);
  border-right: 1px solid var(--border); padding: 20px 12px;
  position: sticky; top: var(--header-h); height: calc(100vh - var(--header-h));
  display: flex; flex-direction: column;
}
.side-section { margin-bottom: 24px; }
.side-group-title {
  font-size: 11px; font-weight: 600; color: var(--text-4);
  letter-spacing: 1px; padding: 0 12px; margin-bottom: 8px; text-transform: uppercase;
}
.side-item {
  display: flex; align-items: center; gap: 10px; height: 40px; padding: 0 12px;
  border-radius: 8px; cursor: pointer; color: var(--text-2);
  font-size: 14px; margin-bottom: 2px; transition: all .18s ease; user-select: none;
}
.side-item:hover { background: var(--bg-hover); color: var(--text-1); transform: translateX(2px); }
.side-item.active { background: var(--mint); color: #00996b; font-weight: 600; }
.side-item .el-icon { font-size: 17px; }
.side-item span:nth-child(2) { flex: 1; }
.side-count { font-size: 11px; color: var(--text-3); background: var(--bg-page); padding: 1px 8px; border-radius: var(--radius-pill); }
.side-item.active .side-count { background: #fff; color: #00996b; }

.side-footer { margin-top: auto; }
.side-promo { padding: 14px 14px 12px; }
.side-promo-title { display: flex; align-items: center; gap: 6px; font-size: 12px; font-weight: 700; color: #00996b; margin-bottom: 6px; }
.side-promo-title .dot { width: 6px; height: 6px; border-radius: 50%; background: var(--brand); animation: wb-floaty 5s ease-in-out infinite; }
.side-promo p { margin: 0; font-size: 11px; color: #6b8f7d; line-height: 1.7; }

/* 主内容 */
.main-content { flex: 1; min-width: 0; padding: 28px 32px 48px; }

@media (max-width: 900px) {
  .sidebar { display: none; }
  .topbar-center { max-width: 50vw; }
  .main-content { padding: 20px; }
  .topbar-link { display: none; }
}
</style>
