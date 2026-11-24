<template>
  <div class="notice-page">
    <div class="page-head reveal">
      <div>
        <h2 class="wb-title">公告通知</h2>
        <p class="wb-sub">平台的最新动态与重要通知 · 点击查看全文</p>
      </div>
    </div>

    <div class="notice-list" v-loading="loading">
      <div v-for="(n, i) in notices" :key="n.id" class="notice-card wb-card reveal"
        :style="{ '--rd': (i % 5) * 70 + 'ms' }" @click="openDetail(n)">
        <div class="notice-cover" v-if="n.tupian">
          <img :src="imgUrl(n.tupian)" alt="公告图片" />
        </div>
        <div class="notice-body">
          <div class="notice-header">
            <h3>{{ n.gonggaobiaoti }}</h3>
            <span class="notice-date">{{ n.faburiqi || n.addtime?.slice(0,10) }}</span>
          </div>
          <p class="notice-content">{{ plainText(n.neirong) || '暂无内容' }}</p>
        </div>
        <el-icon class="notice-arrow"><ArrowRight /></el-icon>
      </div>

      <el-empty v-if="!loading && !notices.length" description="暂无公告" />
    </div>

    <div class="pagination" v-if="total > query.limit">
      <el-pagination v-model:current-page="query.page" v-model:page-size="query.limit"
        :total="total" layout="total, prev, pager, next" background @current-change="loadData" />
    </div>

    <!-- 公告全文抽屉 -->
    <el-drawer v-model="detailVisible" :with-header="false" size="560px">
      <template v-if="current">
        <div class="detail-wrap">
          <img v-if="current.tupian" :src="imgUrl(current.tupian)" class="detail-cover" alt="公告图片" />
          <h2 class="detail-title">{{ current.gonggaobiaoti }}</h2>
          <div class="detail-date">发布于 {{ current.faburiqi || current.addtime || '-' }}</div>
          <div class="detail-divider"></div>
          <div class="rich-content" v-html="current.neirong || '<p>暂无内容</p>'"></div>
        </div>
      </template>
    </el-drawer>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { gonggaoApi } from '@/api'
import { useReveal } from '@/composables/useReveal'

const { refresh } = useReveal()

const loading = ref(false)
const notices = ref([])
const total = ref(0)
const query = reactive({ page: 1, limit: 10 })
const detailVisible = ref(false)
const current = ref(null)

function imgUrl(p) {
  if (!p) return ''
  if (p.startsWith('http')) return p
  return '/springbootpkh49/upload/' + p.split('/').pop()
}
function plainText(html) {
  if (!html) return ''
  const div = document.createElement('div')
  div.innerHTML = html
  return (div.textContent || '').trim()
}
function openDetail(n) { current.value = n; detailVisible.value = true }

async function loadData() {
  loading.value = true
  try {
    const res = await gonggaoApi.page({ page: query.page, limit: query.limit })
    notices.value = res.data?.list || []
    total.value = res.data?.total || 0
    refresh()
  } finally { loading.value = false }
}
onMounted(loadData)
</script>

<style scoped>
.notice-page { max-width: 860px; margin: 0 auto; }
.page-head { margin-bottom: 22px; }

.notice-card {
  display: flex; align-items: center; gap: 18px;
  padding: 18px 20px; margin-bottom: 12px; cursor: pointer;
}
.notice-card.reveal { transition: opacity .7s ease var(--rd, 0s), transform .7s ease var(--rd, 0s); }
.notice-card.reveal.in { transition: transform .25s ease, box-shadow .25s ease; }
.notice-cover { width: 120px; height: 80px; flex-shrink: 0; border-radius: 10px; overflow: hidden; }
.notice-cover img { width: 100%; height: 100%; object-fit: cover; }
.notice-body { flex: 1; min-width: 0; }
.notice-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px; gap: 12px; }
.notice-header h3 { margin: 0; font-size: 15px; font-weight: 600; }
.notice-date { color: var(--text-3); font-size: 12px; flex-shrink: 0; }
.notice-content { color: var(--text-2); font-size: 13px; line-height: 1.7; margin: 0; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
.notice-arrow { color: var(--text-4); flex-shrink: 0; }
.pagination { display: flex; justify-content: center; margin-top: 24px; }

.detail-wrap { padding: 8px 4px; }
.detail-cover { width: 100%; border-radius: var(--radius-m); margin-bottom: 20px; }
.detail-title { font-size: 22px; font-weight: 700; margin: 0 0 10px; line-height: 1.4; }
.detail-date { font-size: 12px; color: var(--text-3); }
.detail-divider { border-top: 1px solid var(--border-light); margin: 20px 0; }
</style>