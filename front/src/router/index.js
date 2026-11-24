import { createRouter, createWebHistory } from 'vue-router'
import Layout from '@/layout/index.vue'

const routes = [
  {
    // 官网落地页（模仿腾讯文档官网），点击「立即体验」进入工作台
    path: '/',
    name: 'Landing',
    component: () => import('@/views/Landing.vue'),
    meta: { title: '墨页 - 在线文档管理平台' }
  },
  {
    // 文档工作台（原前台页面整体迁移到 /workbench 下）
    path: '/workbench',
    component: Layout,
    children: [
      {
        path: '',
        name: 'Home',
        component: () => import('@/views/Home.vue'),
        meta: { title: '概览' }
      },
      {
        path: 'docs',
        name: 'Docs',
        component: () => import('@/views/Docs.vue'),
        meta: { title: '文档中心' }
      },
      {
        path: 'doc/:id',
        name: 'DocReader',
        component: () => import('@/views/DocReader.vue'),
        meta: { title: '阅读文档' }
      },
      {
        path: 'new',
        name: 'DocNew',
        component: () => import('@/views/DocEditor.vue'),
        meta: { title: '新建文档' }
      },
      {
        path: 'edit/:id',
        name: 'DocEdit',
        component: () => import('@/views/DocEditor.vue'),
        meta: { title: '编辑文档' }
      },
      {
        path: 'notices',
        name: 'Notices',
        component: () => import('@/views/Notices.vue'),
        meta: { title: '公告通知' }
      }
    ]
  },
  // 兼容旧链接
  { path: '/docs', redirect: '/workbench/docs' },
  { path: '/notices', redirect: '/workbench/notices' }
]

const router = createRouter({
  history: createWebHistory(),
  routes,
  scrollBehavior() { return { top: 0 } }
})

export default router
