import { createRouter, createWebHistory } from 'vue-router'
import Layout from '@/layout/index.vue'

const routes = [
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/Login.vue'),
    meta: { title: '登录', public: true }
  },
  {
    path: '/',
    component: Layout,
    redirect: '/dashboard',
    children: [
      {
        path: 'dashboard',
        name: 'Dashboard',
        component: () => import('@/views/Dashboard.vue'),
        meta: { title: '首页概览', icon: 'DataBoard' }
      },
      {
        path: 'wendang',
        name: 'Wendang',
        component: () => import('@/views/WendangList.vue'),
        meta: { title: '文档管理', icon: 'Document' }
      },
      {
        path: 'bumen',
        name: 'Bumen',
        component: () => import('@/views/SimpleTable.vue'),
        meta: { title: '部门管理', icon: 'OfficeBuilding', group: 'org' }
      },
      {
        path: 'gangwei',
        name: 'Gangwei',
        component: () => import('@/views/SimpleTable.vue'),
        meta: { title: '岗位管理', icon: 'Postcard', group: 'org' }
      },
      {
        path: 'gonggao',
        name: 'Gonggao',
        component: () => import('@/views/SimpleTable.vue'),
        meta: { title: '公告管理', icon: 'Bell' }
      },
      {
        path: 'yuangong',
        name: 'Yuangong',
        component: () => import('@/views/SimpleTable.vue'),
        meta: { title: '员工管理', icon: 'User', group: 'org' }
      },
      {
        path: 'users',
        name: 'Users',
        component: () => import('@/views/SimpleTable.vue'),
        meta: { title: '账号管理', icon: 'UserFilled', group: 'system' }
      }
    ]
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

// 路由守卫：没 token 就跳登录页（登录页本身放行）
router.beforeEach((to, from, next) => {
  const token = localStorage.getItem('token')
  if (to.meta.public || token) {
    next()
  } else {
    next('/login')
  }
})

export default router
