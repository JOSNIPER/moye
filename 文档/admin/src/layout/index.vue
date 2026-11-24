<template>
  <el-container class="layout">
    <el-aside :width="isCollapse ? '64px' : 'var(--sidebar-w)'" class="aside">
      <div class="logo" @click="isCollapse = !isCollapse">
        <img :src="'/favicon.svg'" alt="墨页 Logo" class="logo-mark" />
        <span v-show="!isCollapse" class="logo-text">墨页 · 管理后台</span>
      </div>

      <el-menu :default-active="route.path" :collapse="isCollapse" :collapse-transition="false"
        router class="side-menu" background-color="transparent" text-color="#595959" active-text-color="#00b96b">
        <div v-for="group in menuGroups" :key="group.title">
          <div v-show="!isCollapse" class="menu-group-title">{{ group.title }}</div>
          <el-menu-item v-for="item in group.items" :key="item.path" :index="'/' + item.path">
            <el-icon><component :is="item.meta.icon" /></el-icon>
            <template #title>{{ item.meta.title }}</template>
          </el-menu-item>
        </div>
      </el-menu>

      <div v-show="!isCollapse" class="aside-bottom">
        <el-icon><InfoFilled /></el-icon> v1.0 · 课程设计项目
      </div>
    </el-aside>

    <el-container class="right-wrap">
      <el-header class="header">
        <div class="header-left">
          <el-icon class="collapse-btn" @click="isCollapse = !isCollapse">
            <component :is="isCollapse ? 'Expand' : 'Fold'" />
          </el-icon>
          <div class="breadcrumb">
            <span>管理后台</span>
            <el-icon><ArrowRight /></el-icon>
            <strong>{{ route.meta.title || '首页' }}</strong>
          </div>
        </div>
        <div class="header-right">
          <el-tooltip content="查看前台门户" placement="bottom">
            <el-button class="icon-btn" circle @click="goFront"><el-icon :size="17"><View /></el-icon></el-button>
          </el-tooltip>
          <el-dropdown @command="handleCommand" trigger="click">
            <div class="user-chip">
              <span class="avatar">管</span>
              <span class="user-name">{{ userInfo.username || '管理员' }}</span>
              <el-icon><ArrowDown /></el-icon>
            </div>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item command="front"><el-icon><View /></el-icon> 查看前台</el-dropdown-item>
                <el-dropdown-item command="logout" divided><el-icon><SwitchButton /></el-icon> 退出登录</el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </div>
      </el-header>

      <el-main class="main">
        <router-view />
      </el-main>
    </el-container>
  </el-container>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessageBox, ElMessage } from 'element-plus'

const route = useRoute()
const router = useRouter()
const isCollapse = ref(false)
const userInfo = computed(() => {
  try { return JSON.parse(localStorage.getItem('userInfo')) || {} } catch { return {} }
})

// 从路由配置自动分组，增删页面只需改 router/index.js 的 meta.group
const allChildren = computed(() => {
  const layoutRoute = router.options.routes.find(r => r.path === '/')
  return layoutRoute?.children || []
})
const menuGroups = computed(() => [
  { title: '工作区', items: allChildren.value.filter(r => r.meta.group !== 'org' && r.meta.group !== 'system') },
  { title: '组织管理', items: allChildren.value.filter(r => r.meta.group === 'org') },
  { title: '系统', items: allChildren.value.filter(r => r.meta.group === 'system') }
])

function goFront() { window.open('http://localhost:5174', '_blank') }
async function handleCommand(cmd) {
  if (cmd === 'front') return goFront()
  if (cmd === 'logout') {
    await ElMessageBox.confirm('确定退出登录吗？', '提示', { type: 'warning' })
    localStorage.removeItem('token')
    localStorage.removeItem('userInfo')
    ElMessage.success('已退出')
    router.push('/login')
  }
}
</script>

<style scoped>
.layout { height: 100vh; }
.aside {
  background: #fff; transition: width .25s; overflow: hidden;
  display: flex; flex-direction: column; border-right: 1px solid var(--border-light);
}
.logo {
  height: var(--header-h); flex-shrink: 0; display: flex; align-items: center; gap: 10px;
  padding: 0 18px; color: var(--text-1); cursor: pointer; white-space: nowrap;
  border-bottom: 1px solid var(--border-light);
}
.logo-mark {
  width: 28px; height: 28px; border-radius: 7px; flex-shrink: 0;
}
.logo-text { font-size: 14px; font-weight: 600; }
.side-menu { flex: 1; border-right: none !important; padding: 12px 8px; overflow-y: auto; }
.side-menu :deep(.el-menu-item) { border-radius: var(--radius-m); margin-bottom: 2px; height: 40px; }
.side-menu :deep(.el-menu-item.is-active) { background: var(--brand-soft) !important; font-weight: 600; }
.side-menu :deep(.el-menu-item:hover) { background: var(--bg-hover) !important; }
.menu-group-title {
  font-size: 10px; letter-spacing: 1.5px; color: var(--text-4); text-transform: uppercase;
  padding: 0 12px; margin: 18px 0 8px; font-weight: 600;
}
.aside-bottom {
  padding: 16px 20px; font-size: 11px; color: var(--text-4);
  display: flex; align-items: center; gap: 6px; border-top: 1px solid var(--border-light);
}

.right-wrap { min-width: 0; }
.header {
  height: var(--header-h); background: #fff; border-bottom: 1px solid var(--border);
  display: flex; align-items: center; justify-content: space-between; padding: 0 24px;
}
.header-left, .header-right { display: flex; align-items: center; gap: 14px; }
.collapse-btn { font-size: 19px; color: var(--text-2); cursor: pointer; }
.breadcrumb { display: flex; align-items: center; gap: 8px; font-size: 13px; color: var(--text-3); }
.breadcrumb strong { color: var(--text-1); font-weight: 600; }
.icon-btn { color: var(--text-2); }
.user-chip { display: flex; align-items: center; gap: 8px; cursor: pointer; font-size: 13px; }
.avatar {
  width: 30px; height: 30px; border-radius: 50%; background: var(--brand-soft);
  color: var(--brand); font-weight: 600; display: flex; align-items: center; justify-content: center;
}
.user-name { color: var(--text-1); }
.main { background: var(--bg-page); padding: 0; overflow-y: auto; }
</style>
