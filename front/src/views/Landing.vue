<template>
  <div class="landing">
    <!-- 顶部导航 -->
    <header class="nav">
      <div class="nav-inner">
        <div class="nav-brand" @click="goWorkbench">
          <img :src="'/favicon.svg'" alt="墨页 Logo" class="brand-logo" />
          <span class="brand-name">墨页</span>
        </div>
        <nav class="nav-links">
          <a v-for="l in navLinks" :key="l.href" :href="l.href" class="nav-link">{{ l.label }}</a>
        </nav>
        <div class="nav-actions">
          <el-button link class="nav-login" @click="goAdmin">管理后台</el-button>
          <button class="pill-btn dark" @click="goWorkbench">立即体验 <span class="pill-arrow">→</span></button>
        </div>
      </div>
    </header>

    <!-- Hero -->
    <section class="hero">
      <div class="hero-glow glow-left"></div>
      <div class="hero-glow glow-right"></div>
      <div class="hero-inner">
        <h1 class="hero-title reveal">墨页</h1>
        <p class="hero-sub reveal d1">写作、管理、沉淀与分享，一个工作台就够了。<br />在线撰写富文本与 Markdown，上传附件、分类检索、版本回溯，让知识留在一个干净安静的地方。</p>
        <div class="hero-actions reveal d2">
          <button class="pill-btn dark big" @click="goWorkbench">立即体验 墨页</button>
        </div>
        <a class="hero-link reveal d3" @click="goDocs">在线浏览文档库 →</a>

        <!-- 产品示意 -->
        <div class="mockup reveal d3">
          <div class="mock-bar">
            <span class="mock-dot r"></span><span class="mock-dot y"></span><span class="mock-dot g"></span>
            <span class="mock-url">localhost:5174/workbench</span>
          </div>
          <div class="mock-body">
            <div class="mock-side">
              <div class="mock-side-item active"></div>
              <div class="mock-side-item"></div>
              <div class="mock-side-item"></div>
              <div class="mock-side-item short"></div>
            </div>
            <div class="mock-main">
              <div class="mock-title"></div>
              <div class="mock-line w80"></div>
              <div class="mock-line w95"></div>
              <div class="mock-line w60"></div>
              <div class="mock-cards">
                <div class="mock-card" v-for="i in 3" :key="i">
                  <div class="mock-card-icon"></div>
                  <div class="mock-line w70"></div>
                  <div class="mock-line w45"></div>
                </div>
              </div>
            </div>
          </div>
          <div class="float-chip chip-1"><span class="chip-dot"></span> Markdown 已导入</div>
          <div class="float-chip chip-2"><span class="chip-dot green"></span> 历史版本 v12 已保存</div>
        </div>
      </div>
    </section>

    <!-- 实时数据条 -->
    <section class="stats-strip">
      <div class="stats-inner reveal">
        <div class="stat" v-for="s in stats" :key="s.label">
          <div class="stat-num">{{ s.display }}</div>
          <div class="stat-label">{{ s.label }}</div>
        </div>
      </div>
    </section>

    <!-- 格式 marquee -->
    <div class="marquee">
      <div class="marquee-track">
        <span v-for="(t, i) in marqueeItems" :key="i" class="marquee-item">{{ t }}</span>
      </div>
    </div>

    <!-- 核心链路 -->
    <section class="section" id="flow">
      <div class="section-inner">
        <h2 class="big-title reveal">从写作到沉淀<br />一条完整链路</h2>
        <p class="big-sub reveal d1">告诉墨页你要写什么，它给你编辑器、分类、检索、版本与下载——写完即沉淀，沉淀即可查。</p>
        <div class="flow-panel reveal d2">
          <div class="flow-card flow-editor">
            <div class="flow-card-head"><span class="fc-dot"></span> 编辑 · Markdown / 富文本</div>
            <div class="mock-line w95"></div>
            <div class="mock-line w80"></div>
            <div class="mock-line w90"></div>
            <div class="typing-line"><span class="typing-text">## 团队知识库建设指南</span><span class="caret"></span></div>
          </div>
          <div class="flow-card flow-reader">
            <div class="flow-card-head"><span class="fc-dot green"></span> 阅读 · 排版渲染</div>
            <div class="flow-reader-title">团队知识库建设指南</div>
            <div class="mock-line w95"></div>
            <div class="mock-line w70"></div>
            <div class="flow-quote">知识库的价值不在于文档数量，而在于被查阅的次数。</div>
          </div>
        </div>
      </div>
    </section>

    <!-- 产品能力 -->
    <section class="section section-mint" id="features">
      <div class="section-inner">
        <h2 class="big-title reveal">该有的能力，一个不少</h2>
        <p class="big-sub reveal d1">围绕「写、存、找、读、回溯」五件事，把文档管理做扎实。</p>
        <div class="feature-grid">
          <div class="feature-card reveal" v-for="(f, i) in features" :key="f.title" :style="{ transitionDelay: (i % 3) * 90 + 'ms' }">
            <el-icon class="feature-icon" :size="26"><component :is="f.icon" /></el-icon>
            <h3>{{ f.title }}</h3>
            <p>{{ f.desc }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- 使用场景 -->
    <section class="section" id="scenes">
      <div class="section-inner">
        <h2 class="big-title reveal">这些场景，都合适</h2>
        <p class="big-sub reveal d1">个人笔记、团队知识库、课程资料，都能装进来；按项目聚合，跨格式统一管理。</p>
        <div class="scene-grid">
          <div class="scene-card reveal" v-for="(s, i) in scenes" :key="s.title" :style="{ transitionDelay: i * 90 + 'ms' }">
            <span class="scene-tag">{{ s.tag }}</span>
            <h3>{{ s.title }}</h3>
            <p>{{ s.desc }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- 底部 CTA -->
    <section class="cta">
      <span class="cta-badge reveal">免费开始 · 无需注册 GET STARTED</span>
      <h2 class="cta-title reveal d1">现在开始 高效沉淀</h2>
      <div class="reveal d2">
        <button class="pill-btn dark big" @click="goWorkbench">进入工作台 →</button>
      </div>
    </section>

    <!-- 黑色页脚 -->
    <footer class="footer">
      <div class="footer-inner">
        <div class="footer-brand">
          <img :src="'/favicon.svg'" alt="Logo" class="brand-logo" />
          <span>墨页</span>
        </div>
        <p class="footer-desc">轻量在线文档平台。在线撰写、附件管理、分类检索、版本回溯，从需求到沉淀一站搞定。</p>
        <div class="footer-cols">
          <div class="footer-col">
            <h4>产品</h4>
            <a @click="goWorkbench">文档工作台</a>
            <a @click="goDocs">文档中心</a>
            <a @click="$router.push('/workbench/notices')">公告通知</a>
          </div>
          <div class="footer-col">
            <h4>能力</h4>
            <a @click="goWorkbench">在线撰写</a>
            <a @click="goWorkbench">Markdown 导入</a>
            <a @click="goWorkbench">历史版本</a>
          </div>
          <div class="footer-col">
            <h4>关于</h4>
            <a @click="goAdmin">管理后台</a>
            <a href="#flow">产品链路</a>
            <a href="#features">能力清单</a>
          </div>
        </div>
        <div class="footer-base">
          <span>基于 SpringBoot + Vue3 的在线文档管理系统 · 前端设计课程项目</span>
          <span>© 2026 墨页</span>
        </div>
      </div>
      <div class="footer-word">墨页</div>
    </footer>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, onBeforeUnmount } from 'vue'
import { useRouter } from 'vue-router'
import { wendangApi, lishiApi } from '@/api'

const router = useRouter()
const goWorkbench = () => router.push('/workbench')
const goDocs = () => router.push('/workbench/docs')
const goAdmin = () => window.open('http://localhost:5173', '_blank')

const navLinks = [
  { label: '产品链路', href: '#flow' },
  { label: '产品能力', href: '#features' },
  { label: '使用场景', href: '#scenes' }
]

const features = [
  { icon: 'EditPen', title: '在线撰写', desc: '富文本与 Markdown 双编辑器，标题、列表、引用、图片、表格，打开浏览器就能写。' },
  { icon: 'Upload', title: '拖拽导入', desc: '.md 拖入即成在线文档，Word / PPT / Excel / PDF 拖入即成附件文档，零配置。' },
  { icon: 'Reading', title: '沉浸阅读', desc: '纸张式阅读页，Markdown 实时渲染预览，长文阅读也舒服。' },
  { icon: 'Clock', title: '历史版本', desc: '每次保存自动快照，单篇保留 50 版，可预览任意版本并一键恢复。' },
  { icon: 'FolderOpened', title: '项目分类', desc: '格式分类之外按项目聚合，一个项目容纳各种格式，访客与管理员都能归位。' },
  { icon: 'Search', title: '快速检索', desc: '关键词模糊搜索、命中高亮、类型与项目筛选、日期排序，找文档不费劲。' }
]

const scenes = [
  { tag: '团队', title: '团队知识库', desc: '制度、流程、入职指引统一沉淀，新成员进来就有据可查。' },
  { tag: '个人', title: '个人写作空间', desc: '草稿、笔记、随想，打开就写，写完就存，不用来回传文件。' },
  { tag: '课程', title: '课程资料中心', desc: '讲义、作业模板、参考附件分类归档，检索一步到位。' }
]

const marqueeItems = ['Markdown', 'Word', 'PPT', 'Excel', 'PDF', '在线文档', '富文本', '历史版本', '项目分类', '拖拽导入',
  'Markdown', 'Word', 'PPT', 'Excel', 'PDF', '在线文档', '富文本', '历史版本', '项目分类', '拖拽导入']

// 实时数据 + 数字滚动
const stats = reactive([
  { label: '在库文档', value: 0, display: '0' },
  { label: '在线正文', value: 0, display: '0' },
  { label: '历史版本快照', value: 0, display: '0' },
  { label: '项目分组', value: 0, display: '0' }
])

function countUp(s) {
  const dur = 1200
  const t0 = performance.now()
  const tick = (t) => {
    const p = Math.min(1, (t - t0) / dur)
    s.display = String(Math.round(s.value * (1 - Math.pow(1 - p, 3))))
    if (p < 1) requestAnimationFrame(tick)
  }
  requestAnimationFrame(tick)
}

async function loadStats() {
  try {
    const [docs, his] = await Promise.all([
      wendangApi.page({ page: 1, limit: 1000 }),
      lishiApi.page({ page: 1, limit: 1 })
    ])
    const all = docs.data?.list || []
    const has = d => ((d.neirong || '').replace(/<[^>]+>/g, '').trim().length > 0) || ((d.neirongmd || '').trim().length > 0)
    stats[0].value = docs.data?.total || all.length
    stats[1].value = all.filter(has).length
    stats[2].value = his.data?.total || 0
    stats[3].value = new Set(all.map(d => (d.xiangmu || '').trim()).filter(Boolean)).size
  } catch (e) { console.error(e) }
}

// 滚动显现
let io = null
onMounted(() => {
  loadStats()
  io = new IntersectionObserver((entries) => {
    entries.forEach(en => {
      if (en.isIntersecting) {
        en.target.classList.add('in')
        if (en.target.classList.contains('stats-inner')) stats.forEach(countUp)
        io.unobserve(en.target)
      }
    })
  }, { threshold: 0.15 })
  document.querySelectorAll('.reveal').forEach(el => io.observe(el))
})
onBeforeUnmount(() => io?.disconnect())
</script>

<style scoped>
.landing { background: #fff; color: #111; overflow-x: hidden; }

/* 滚动显现 */
.reveal { opacity: 0; transform: translateY(26px); transition: opacity .7s ease, transform .7s ease; }
.reveal.in { opacity: 1; transform: none; }
.d1 { transition-delay: .12s; } .d2 { transition-delay: .24s; } .d3 { transition-delay: .36s; }

/* 导航 */
.nav { position: sticky; top: 0; z-index: 100; background: rgba(255,255,255,.9); backdrop-filter: blur(10px); border-bottom: 1px solid #f0f0f0; }
.nav-inner { max-width: 1200px; margin: 0 auto; padding: 0 32px; height: 64px; display: flex; align-items: center; justify-content: space-between; }
.nav-brand { display: flex; align-items: center; gap: 9px; cursor: pointer; }
.brand-logo { width: 30px; height: 30px; border-radius: 8px; }
.brand-name { font-size: 17px; font-weight: 800; letter-spacing: .3px; }
.nav-links { display: flex; gap: 30px; }
.nav-link { position: relative; color: #444; text-decoration: none; font-size: 14px; padding: 6px 0; }
.nav-link::after { content: ''; position: absolute; left: 0; right: 100%; bottom: 0; height: 2px; background: #00b96b; transition: right .25s ease; }
.nav-link:hover { color: #111; }
.nav-link:hover::after { right: 0; }
.nav-actions { display: flex; align-items: center; gap: 14px; }
.nav-login { color: #444; font-size: 14px; }

/* 胶囊按钮 */
.pill-btn {
  border: none; cursor: pointer; border-radius: 999px; font-weight: 600;
  background: #111; color: #fff; padding: 10px 22px; font-size: 14px;
  transition: transform .2s ease, box-shadow .2s ease;
}
.pill-btn:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(0,0,0,.18); }
.pill-btn.big { padding: 15px 34px; font-size: 16px; }
.pill-arrow { display: inline-block; transition: transform .2s; }
.pill-btn:hover .pill-arrow { transform: translateX(3px); }

/* Hero */
.hero { position: relative; padding: 96px 32px 0; text-align: center; }
.hero-glow { position: absolute; width: 560px; height: 560px; border-radius: 50%; filter: blur(10px); pointer-events: none;
  background: radial-gradient(circle, rgba(0,185,107,.16), transparent 65%); animation: breathe 7s ease-in-out infinite; }
.glow-left { left: -220px; bottom: -120px; }
.glow-right { right: -220px; bottom: -60px; animation-delay: 3.5s; }
@keyframes breathe { 0%,100% { opacity: .7; transform: scale(1); } 50% { opacity: 1; transform: scale(1.12); } }
.hero-inner { position: relative; max-width: 1000px; margin: 0 auto; }
.hero-title { font-size: 76px; font-weight: 800; letter-spacing: 2px; margin: 0 0 24px; line-height: 1.1; }
.hero-sub { font-size: 16px; color: #666; line-height: 1.9; margin: 0 0 36px; }
.hero-actions { display: flex; justify-content: center; }
.hero-link { display: inline-block; margin: 18px 0 56px; color: #00996b; font-size: 14px; cursor: pointer; }
.hero-link:hover { text-decoration: underline; }

/* 产品示意 */
.mockup { position: relative; border: 1px solid #ececec; border-radius: 14px 14px 0 0; border-bottom: none; overflow: visible; text-align: left; box-shadow: 0 18px 60px rgba(0,0,0,.08); background: #fff; }
.mock-bar { display: flex; align-items: center; gap: 6px; padding: 12px 16px; border-bottom: 1px solid #f0f0f0; background: #fafafa; border-radius: 14px 14px 0 0; }
.mock-dot { width: 10px; height: 10px; border-radius: 50%; }
.mock-dot.r { background: #ff5f57; } .mock-dot.y { background: #febc2e; } .mock-dot.g { background: #28c840; }
.mock-url { margin-left: 10px; font-size: 11px; color: #999; background: #fff; border: 1px solid #f0f0f0; border-radius: 5px; padding: 3px 12px; }
.mock-body { display: flex; min-height: 320px; }
.mock-side { width: 190px; border-right: 1px solid #f0f0f0; padding: 20px 16px; background: #fafafa; }
.mock-side-item { height: 12px; border-radius: 5px; background: #ececec; margin-bottom: 15px; }
.mock-side-item.active { background: #d9f2e5; }
.mock-side-item.short { width: 60%; }
.mock-main { flex: 1; padding: 28px 32px; }
.mock-title { height: 18px; width: 40%; border-radius: 5px; background: #d9d9d9; margin-bottom: 18px; }
.mock-line { height: 10px; border-radius: 5px; background: #f0f0f0; margin-bottom: 12px; }
.w95 { width: 95%; } .w90 { width: 90%; } .w80 { width: 80%; } .w70 { width: 70%; } .w60 { width: 60%; } .w45 { width: 45%; }
.mock-cards { display: grid; grid-template-columns: repeat(3, 1fr); gap: 14px; margin-top: 22px; }
.mock-card { border: 1px solid #f0f0f0; border-radius: 10px; padding: 14px; }
.mock-card-icon { width: 28px; height: 28px; border-radius: 7px; background: #d9f2e5; margin-bottom: 12px; }
.float-chip {
  position: absolute; display: flex; align-items: center; gap: 7px;
  background: rgba(255,255,255,.92); backdrop-filter: blur(6px); border: 1px solid #ececec;
  border-radius: 999px; padding: 8px 16px; font-size: 12px; color: #333;
  box-shadow: 0 8px 24px rgba(0,0,0,.08); animation: floaty 5s ease-in-out infinite;
}
.chip-1 { top: 70px; right: -34px; }
.chip-2 { bottom: 60px; left: -40px; animation-delay: 2.5s; }
.chip-dot { width: 7px; height: 7px; border-radius: 50%; background: #febc2e; }
.chip-dot.green { background: #00b96b; }
@keyframes floaty { 0%,100% { transform: translateY(0); } 50% { transform: translateY(-10px); } }

/* 数据条 */
.stats-strip { border-top: 1px solid #f0f0f0; border-bottom: 1px solid #f0f0f0; background: #fafafa; }
.stats-inner { max-width: 1000px; margin: 0 auto; display: grid; grid-template-columns: repeat(4, 1fr); padding: 36px 32px; }
.stat { text-align: center; }
.stat-num { font-size: 38px; font-weight: 800; letter-spacing: -.5px; font-variant-numeric: tabular-nums; }
.stat-label { font-size: 12px; color: #888; margin-top: 6px; }

/* marquee */
.marquee { overflow: hidden; padding: 18px 0; border-bottom: 1px solid #f0f0f0; background: #fff; }
.marquee-track { display: flex; gap: 44px; width: max-content; animation: scroll-x 26s linear infinite; }
.marquee-item { font-size: 13px; color: #aaa; letter-spacing: 1px; white-space: nowrap; }
.marquee-item::before { content: '◆'; color: #00b96b; font-size: 8px; margin-right: 12px; vertical-align: 2px; }
@keyframes scroll-x { from { transform: translateX(0); } to { transform: translateX(-50%); } }

/* 区块 */
.section { padding: 96px 32px; }
.section-inner { max-width: 1200px; margin: 0 auto; }
.big-title { font-size: 44px; font-weight: 800; line-height: 1.3; letter-spacing: -.5px; margin: 0 0 16px; }
.big-sub { font-size: 15px; color: #777; line-height: 1.9; margin: 0 0 48px; max-width: 640px; }
.section-mint { background: linear-gradient(180deg, #f4fbf7, #eef9f3); border-top: 1px solid #e5f5ec; border-bottom: 1px solid #e5f5ec; }

/* 链路面板 */
.flow-panel {
  position: relative; border-radius: 18px; padding: 56px 48px;
  background: linear-gradient(135deg, #e7f8ef, #f2fbf6 60%, #e0f5ea);
  display: flex; gap: 28px; align-items: flex-start; overflow: hidden;
}
.flow-panel::before { content: ''; position: absolute; inset: 0;
  background-image: linear-gradient(#00b96b0d 1px, transparent 1px), linear-gradient(90deg, #00b96b0d 1px, transparent 1px);
  background-size: 44px 44px; }
.flow-card { position: relative; background: #fff; border-radius: 12px; box-shadow: 0 14px 40px rgba(0,60,35,.10); padding: 22px 24px; }
.flow-editor { flex: 1.1; transform: rotate(-1.2deg); }
.flow-reader { flex: 1; margin-top: 44px; transform: rotate(1deg); }
.flow-card-head { display: flex; align-items: center; gap: 7px; font-size: 12px; color: #888; margin-bottom: 16px; }
.fc-dot { width: 8px; height: 8px; border-radius: 50%; background: #febc2e; }
.fc-dot.green { background: #00b96b; }
.flow-reader-title { font-size: 17px; font-weight: 700; margin-bottom: 12px; }
.flow-quote { margin-top: 14px; padding: 10px 14px; border-left: 3px solid #00b96b; background: #f6fbf8; font-size: 12px; color: #555; line-height: 1.7; }
.typing-line { margin-top: 14px; font-size: 13px; color: #00996b; font-family: Consolas, monospace; }
.caret { display: inline-block; width: 2px; height: 14px; background: #00b96b; vertical-align: -2px; margin-left: 2px; animation: blink 1s steps(1) infinite; }
@keyframes blink { 50% { opacity: 0; } }

/* 能力卡 */
.feature-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; }
.feature-card { background: #fff; border: 1px solid #e8f3ec; border-radius: 14px; padding: 28px; transition: transform .25s ease, box-shadow .25s ease, opacity .7s ease; }
.feature-card:hover { transform: translateY(-5px); box-shadow: 0 14px 34px rgba(0,60,35,.08); }
.feature-icon { color: #00b96b; margin-bottom: 16px; }
.feature-card h3 { font-size: 17px; font-weight: 700; margin: 0 0 10px; }
.feature-card p { font-size: 13px; color: #666; line-height: 1.9; margin: 0; }

/* 场景 */
.scene-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; }
.scene-card { border: 1px solid #ececec; border-radius: 14px; padding: 28px; transition: transform .25s ease, box-shadow .25s ease, opacity .7s ease; }
.scene-card:hover { transform: translateY(-5px); box-shadow: 0 14px 34px rgba(0,0,0,.06); }
.scene-tag { display: inline-block; font-size: 11px; color: #00996b; background: #e8f7f0; padding: 3px 12px; border-radius: 999px; margin-bottom: 16px; }
.scene-card h3 { font-size: 17px; font-weight: 700; margin: 0 0 10px; }
.scene-card p { font-size: 13px; color: #666; line-height: 1.9; margin: 0; }

/* CTA */
.cta { text-align: center; padding: 104px 32px; }
.cta-badge { display: inline-block; font-size: 12px; color: #00996b; background: #e8f7f0; border-radius: 999px; padding: 6px 16px; letter-spacing: 1px; margin-bottom: 24px; }
.cta-title { font-size: 48px; font-weight: 800; letter-spacing: -.5px; margin: 0 0 36px; }

/* 黑色页脚 */
.footer { background: #0a0a0a; color: #fff; padding: 64px 32px 0; overflow: hidden; }
.footer-inner { max-width: 1200px; margin: 0 auto; }
.footer-brand { display: flex; align-items: center; gap: 10px; font-size: 20px; font-weight: 800; }
.footer-desc { color: #999; font-size: 13px; line-height: 1.9; max-width: 420px; margin: 18px 0 40px; }
.footer-cols { display: flex; gap: 88px; padding-bottom: 48px; }
.footer-col h4 { font-size: 14px; font-weight: 700; margin: 0 0 18px; }
.footer-col a { display: block; color: #999; font-size: 13px; margin-bottom: 12px; cursor: pointer; text-decoration: none; }
.footer-col a:hover { color: #fff; }
.footer-base { display: flex; justify-content: space-between; gap: 16px; flex-wrap: wrap; border-top: 1px solid #222; padding: 22px 0; color: #777; font-size: 12px; }
.footer-word {
  font-size: 190px; font-weight: 900; line-height: .9; letter-spacing: 10px; text-align: center;
  color: transparent; -webkit-text-stroke: 1px #2c2c2c; user-select: none; white-space: nowrap;
  transform: translateY(18px);
}

@media (max-width: 900px) {
  .nav-links { display: none; }
  .hero-title { font-size: 44px; }
  .big-title { font-size: 30px; }
  .cta-title { font-size: 32px; }
  .stats-inner { grid-template-columns: repeat(2, 1fr); gap: 24px; }
  .feature-grid, .scene-grid { grid-template-columns: 1fr; }
  .flow-panel { flex-direction: column; padding: 32px 20px; }
  .flow-reader { margin-top: 0; }
  .float-chip { display: none; }
  .footer-cols { gap: 40px; flex-wrap: wrap; }
  .footer-word { font-size: 80px; }
}
</style>