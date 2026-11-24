<template>
  <div class="home">
    <!-- 欢迎区：官网 hero 的工作台尺度 -->
    <div class="welcome reveal">
      <div class="wb-glow glow-a"></div>
      <div class="welcome-copy">
        <span class="wb-badge"><span class="dot"></span> 文档工作台 · WORKBENCH</span>
        <h1>{{ greeting }}，访客</h1>
        <p class="wb-sub">在这里阅读、撰写和管理你的文档——写完即沉淀，沉淀即可查。</p>
      </div>
      <button class="pill-btn big" @click="$router.push('/workbench/new')">
        <el-icon><Plus /></el-icon> 新建文档 <span class="pill-arrow">→</span>
      </button>
    </div>

    <!-- 数据条：官网 stats-strip 同款 + countUp -->
    <div class="stats-band wb-card reveal d1">
      <div class="stat" v-for="s in stats" :key="s.label" @click="s.to && $router.push(s.to)">
        <div class="stat-num">{{ s.display }}</div>
        <div class="stat-label"><span class="stat-dot"></span>{{ s.label }}</div>
      </div>
    </div>

    <!-- 格式 marquee：官网同款横向滚动 -->
    <div class="wb-marquee reveal d2">
      <div class="wb-marquee-track">
        <span v-for="(t, i) in marqueeItems" :key="i" class="wb-marquee-item">{{ t }}</span>
      </div>
    </div>

    <el-row :gutter="16" class="content-row">
      <!-- 最近文档 -->
      <el-col :span="16">
        <div class="panel wb-card reveal d1">
          <div class="panel-header">
            <div class="panel-title">最近更新</div>
            <a class="panel-link" @click="$router.push('/workbench/docs')">查看全部 <span class="pill-arrow">→</span></a>
          </div>
          <div class="doc-list">
            <div v-for="doc in docs" :key="doc.id" class="doc-row" @click="openDoc(doc)">
              <div class="doc-file-icon" :style="{ background: typeColor(doc.leixing) + '14', color: typeColor(doc.leixing) }">
                <el-icon :size="18"><Document /></el-icon>
              </div>
              <div class="doc-row-main">
                <div class="doc-row-title text-ellipsis">{{ doc.wendangmingcheng }}</div>
                <div class="doc-row-meta">{{ doc.leixing }} · {{ doc.faburiqi || doc.addtime?.slice(0,10) }}</div>
              </div>
              <span v-if="hasContent(doc)" class="online-chip">在线正文</span>
              <span v-if="doc.xiangmu" class="project-chip text-ellipsis">{{ doc.xiangmu }}</span>
              <el-icon class="doc-row-arrow"><ArrowRight /></el-icon>
            </div>
            <el-empty v-if="!docs.length" description="暂无文档" :image-size="60" />
          </div>
        </div>
      </el-col>

      <!-- 公告 + 快捷入口 -->
      <el-col :span="8">
        <div class="panel wb-card reveal d2">
          <div class="panel-header">
            <div class="panel-title">公告通知</div>
            <a class="panel-link" @click="$router.push('/workbench/notices')">更多 <span class="pill-arrow">→</span></a>
          </div>
          <div class="notice-list">
            <div v-for="n in notices" :key="n.id" class="notice-row" @click="$router.push('/workbench/notices')">
              <span class="notice-dot"></span>
              <span class="notice-title text-ellipsis">{{ n.gonggaobiaoti }}</span>
              <span class="notice-date">{{ n.faburiqi?.slice(5) || '' }}</span>
            </div>
            <el-empty v-if="!notices.length" description="暂无公告" :image-size="50" />
          </div>
        </div>

        <div class="panel wb-card reveal d3">
          <div class="panel-header"><div class="panel-title">快捷入口</div></div>
          <div class="quick-grid">
            <div class="quick-item" @click="$router.push('/workbench/new')">
              <el-icon :size="18"><EditPen /></el-icon><span>写文档</span>
            </div>
            <div class="quick-item" @click="$router.push('/workbench/docs')">
              <el-icon :size="18"><Folder /></el-icon><span>全部文档</span>
            </div>
            <div class="quick-item" @click="$router.push('/workbench/docs?type=Word')">
              <el-icon :size="18"><Document /></el-icon><span>Word</span>
            </div>
            <div class="quick-item" @click="$router.push('/workbench/notices')">
              <el-icon :size="18"><Bell /></el-icon><span>公告</span>
            </div>
          </div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { wendangApi, gonggaoApi, typeColor } from '@/api'
import { useReveal, countUp } from '@/composables/useReveal'

const router = useRouter()
const docs = ref([])
const notices = ref([])
const allDocs = ref([])
const noticeTotal = ref(0)
useReveal()

const greeting = computed(() => {
  const h = new Date().getHours()
  if (h < 6) return '夜深了'
  if (h < 12) return '早上好'
  if (h < 18) return '下午好'
  return '晚上好'
})

const marqueeItems = ['Markdown', 'Word', 'PPT', 'Excel', 'PDF', '在线文档', '富文本', '历史版本', '项目分类', '拖拽导入',
  'Markdown', 'Word', 'PPT', 'Excel', 'PDF', '在线文档', '富文本', '历史版本', '项目分类', '拖拽导入']

const stats = reactive([
  { label: '文档总数', value: 0, display: '0', to: '/workbench/docs' },
  { label: '在线正文', value: 0, display: '0', to: '/workbench/docs' },
  { label: '附件文档', value: 0, display: '0', to: '/workbench/docs' },
  { label: '公告通知', value: 0, display: '0', to: '/workbench/notices' }
])

function hasContent(doc) {
  const html = doc.neirong || ''
  const md = (doc.neirongmd || '').trim()
  return md.length > 0 || html.replace(/<[^>]+>/g, '').trim().length > 0 || /<img|<table/i.test(html)
}
function openDoc(doc) { router.push('/workbench/doc/' + doc.id) }

onMounted(async () => {
  try {
    const [docRes, allRes, noticeRes] = await Promise.all([
      wendangApi.page({ page: 1, limit: 6, sidx: 'addtime', order: 'DESC' }),
      wendangApi.page({ page: 1, limit: 1000 }),
      gonggaoApi.page({ page: 1, limit: 5 })
    ])
    docs.value = docRes.data?.list || []
    allDocs.value = allRes.data?.list || []
    notices.value = noticeRes.data?.list || []
    noticeTotal.value = noticeRes.data?.total || 0
    stats[0].value = allRes.data?.total || allDocs.value.length
    stats[1].value = allDocs.value.filter(hasContent).length
    stats[2].value = allDocs.value.filter(d => d.fujian).length
    stats[3].value = noticeTotal.value
    stats.forEach(countUp)
  } catch (e) { console.error('首页数据加载失败', e) }
})
</script>

<style scoped>
.home { max-width: 1360px; margin: 0 auto; }

/* 欢迎区 */
.welcome {
  position: relative; display: flex; align-items: center; justify-content: space-between;
  gap: 24px; padding: 36px 8px 32px; margin-bottom: 8px; overflow: hidden;
}
.glow-a { left: -140px; top: -160px; }
.welcome-copy { position: relative; }
.welcome h1 { font-size: 40px; font-weight: 800; letter-spacing: -.8px; margin: 14px 0 10px; color: var(--ink); line-height: 1.2; }
.welcome .wb-badge { margin-bottom: 0; }

/* 数据条 */
.stats-band { display: grid; grid-template-columns: repeat(4, 1fr); padding: 28px 16px; margin-bottom: 16px; }
.stats-band:hover { transform: none; box-shadow: var(--shadow-1); }
.stat { text-align: center; cursor: pointer; }
.stat-num { font-size: 36px; font-weight: 800; letter-spacing: -.5px; color: var(--ink); font-variant-numeric: tabular-nums; line-height: 1.1; }
.stat-label { display: flex; align-items: center; justify-content: center; gap: 6px; font-size: 12px; color: #888; margin-top: 8px; }
.stat-dot { width: 6px; height: 6px; border-radius: 50%; background: var(--brand); }
.stat:hover .stat-num { color: #00996b; }

.wb-marquee { border-radius: 0; margin-bottom: 20px; border-left: none; border-right: none; }

.content-row { margin-bottom: 0; }
.panel { overflow: hidden; }
.panel + .panel { margin-top: 16px; }
.panel:hover { transform: none; box-shadow: var(--shadow-1); }
.panel-header {
  height: 52px; padding: 0 20px; display: flex; align-items: center; justify-content: space-between;
  border-bottom: 1px solid var(--border-light);
}
.panel-title { font-size: 15px; font-weight: 700; color: var(--ink); }
.panel-link { display: inline-flex; align-items: center; gap: 4px; color: #00996b; font-size: 13px; cursor: pointer; }
.panel-link:hover { text-decoration: underline; }
.panel-link:hover .pill-arrow { transform: translateX(3px); }

.doc-list { padding: 4px 0; }
.doc-row {
  display: flex; align-items: center; gap: 12px; padding: 11px 20px;
  cursor: pointer; transition: background .15s;
}
.doc-row:hover { background: var(--mint-2); }
.doc-file-icon { width: 36px; height: 36px; border-radius: 10px; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
.doc-row-main { flex: 1; min-width: 0; }
.doc-row-title { font-size: 14px; font-weight: 600; margin-bottom: 3px; }
.doc-row-meta { font-size: 12px; color: var(--text-3); }
.online-chip {
  font-size: 11px; color: #00996b; background: var(--mint);
  padding: 3px 10px; border-radius: var(--radius-pill); flex-shrink: 0;
}
.project-chip {
  font-size: 11px; color: var(--text-3); border: 1px solid var(--border-light);
  padding: 3px 10px; border-radius: var(--radius-pill); max-width: 120px; flex-shrink: 0;
}
.doc-row-arrow { color: var(--text-4); }

.notice-list { padding: 4px 0; }
.notice-row { display: flex; align-items: center; gap: 8px; padding: 10px 20px; cursor: pointer; font-size: 13px; }
.notice-row:hover { background: var(--mint-2); }
.notice-dot { width: 5px; height: 5px; border-radius: 50%; background: var(--brand); flex-shrink: 0; }
.notice-title { flex: 1; }
.notice-date { font-size: 11px; color: var(--text-4); }

.quick-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 8px; padding: 16px 20px; }
.quick-item {
  display: flex; flex-direction: row; align-items: center; justify-content: center; gap: 8px;
  padding: 11px 4px; border-radius: 10px; cursor: pointer;
  font-size: 12px; color: var(--text-2); transition: all .18s ease; white-space: nowrap;
}
.quick-item:hover { background: var(--mint); color: #00996b; transform: translateY(-2px); }

@media (max-width: 900px) {
  .welcome { flex-direction: column; align-items: flex-start; }
  .welcome h1 { font-size: 30px; }
  .stats-band { grid-template-columns: repeat(2, 1fr); gap: 20px; }
}
</style>