// 演示内容 v3：示例文档全部重写为「墨页」项目功能介绍，公告重写为产品更新日志
// 附件文件与公告封面图片保持不动；md 演示文档（校园网运维巡检手册）保留作真实项目示例
// 运行：node seed-demo-content.mjs   （需后端 8080 已启动；可重复运行，历史首版按备注去重）
const BASE = 'http://localhost:8080/springbootpkh49'

const DOCS = [
  {
    id: 1, wendangmingcheng: '墨页平台总览', leixing: '在线文档', xiangmu: '产品手册', fujian: '',
    wendangjieshao: '平台定位、技术架构与设计语言总览。',
    neirong: `<p>墨页是一个轻量在线文档管理平台：写作、管理、沉淀与分享，一个工作台就够了。</p>
<h2>定位</h2>
<p>把散落的文件与想法变成<strong>可检索、可维护</strong>的文档资产：在线写作即写即沉淀，附件上传统一归档，项目分类跨格式聚合。</p>
<h2>技术架构</h2>
<ul><li>后端：SpringBoot 2.2.2 + MyBatis-Plus + MySQL，统一 REST 接口与 Token 鉴权；</li><li>前端：Vue3 + Vite6 + Element Plus，访客工作台与管理后台双前端；</li><li>编辑器：wangEditor 富文本与 MdEditor Markdown 双引擎。</li></ul>
<h2>设计语言</h2>
<p>浅色极简底、薄荷绿主色，黑胶囊主按钮、超大黑标题与薄荷网格面板；工作台与官网共用同一套视觉基因，并支持真暗色模式。</p>`
  },
  {
    id: 2, wendangmingcheng: '在线写作与阅读', leixing: '在线文档', xiangmu: '产品手册',
    wendangjieshao: '富文本与 Markdown 双引擎写作、纸张式阅读体验说明。',
    neirong: `<p>工作台提供富文本与 Markdown 两种写作形态，写完即存，存完即可在文档中心检索与阅读。</p>
<h2>写作</h2>
<ul><li>富文本：wangEditor 编辑器，标题、列表、引用、图片与表格所见即所得；</li><li>Markdown：MdEditor 源码编辑、实时预览，适合技术文档与手册；</li><li>保存时自动记录历史版本，误改可随时回退。</li></ul>
<h2>阅读</h2>
<p>阅读页采用纸张式排版：薄荷引用简介、清晰标题层级、代码块高亮；操作条提供编辑、历史、下载胶囊按钮，读写切换不离开页面。</p>
<blockquote>写完即沉淀，沉淀即可查——这是墨页的核心循环。</blockquote>`
  },
  {
    id: 3, wendangmingcheng: 'Markdown 全链路', leixing: '在线文档', xiangmu: '产品手册',
    wendangjieshao: 'Markdown 导入、编辑、预览、下载四段全链路说明。',
    neirong: `<p>Markdown 在墨页是一等公民：导入、编辑、预览、下载四段全部打通。</p>
<h2>导入</h2>
<p>支持 .md 文件选择上传与拖拽导入，导入后自动建档并记录首版历史。</p>
<h2>编辑与预览</h2>
<p>MdEditor 源码模式与预览模式自由切换；阅读页由 MdPreview 渲染，标题、表格、代码块完整支持，暗色模式下同步换肤。</p>
<h2>下载</h2>
<p>一键导出当前内容为 .md 文件，文件名与文档名一致，离开平台也能在其他工具里继续使用。</p>`
  },
  {
    id: 4, wendangmingcheng: '历史版本与恢复', leixing: '在线文档', xiangmu: '产品手册',
    wendangjieshao: '保存自动快照、50 版上限与恢复机制说明。',
    neirong: `<p>每次保存都会生成快照，每次误改都有后悔药。</p>
<h2>自动快照</h2>
<p>文档保存时系统把保存前内容写入历史版本表，单文档自动裁剪保留最近 50 版，无需手动维护。</p>
<h2>查看与恢复</h2>
<p>历史抽屉按时间倒序列出各版本，可预览每版正文；恢复前先对当前内容快照，再覆盖为目标版本，恢复操作本身也可追溯。</p>
<h2>适用场景</h2>
<ul><li>误删大段内容，想找回上一版；</li><li>对比两次修改的措辞差异；</li><li>多人改乱后回退到稳定版本。</li></ul>`
  },
  {
    id: 5, wendangmingcheng: '项目分类与检索', leixing: '在线文档', xiangmu: '产品手册',
    wendangjieshao: '项目聚合、格式筛选与全局搜索说明。',
    neirong: `<p>文档可以归属项目，跨格式聚合，一次筛选直达全部。</p>
<h2>项目分类</h2>
<p>在线文档、Markdown、Word、PPT、Excel 任意格式都可归属同一项目；侧栏项目分类实时计数，点击进入该项目聚合视图。</p>
<h2>检索</h2>
<ul><li>顶栏全局搜索：文档名称与简介模糊匹配；</li><li>文档中心格式筛选：在线正文 / Markdown / Word / PPT / Excel 分类查看；</li><li>项目筛选与格式筛选可叠加，逐层收窄。</li></ul>
<h2>管理端</h2>
<p>后台文档列表提供项目列与搜索框，可批量维护归属与简介，前台聚合始终准确。</p>`
  },
  {
    id: 12, wendangmingcheng: '附件管理与格式支持', leixing: '在线文档', xiangmu: '产品手册',
    wendangjieshao: 'Office 附件上传、拖拽与下载支持说明。',
    neirong: `<p>离线文件也是文档资产：墨页为 Office 附件提供统一上传、归档与下载。</p>
<h2>支持格式</h2>
<ul><li>Word（.doc / .docx）：手册、制度、报告；</li><li>PPT（.ppt / .pptx）：演示、课件、答辩稿；</li><li>Excel（.xls / .xlsx）：台账、统计、名单。</li></ul>
<h2>上传与拖拽</h2>
<p>文档中心支持按钮上传与整页拖拽：文件落页即自动建档，记录格式徽章与首版历史。</p>
<h2>下载与阅读</h2>
<p>附件文档在阅读页提供原文件下载；在线正文与附件可共存，正文用于快速浏览，附件用于深度阅读。</p>`
  },
  {
    id: 13, wendangmingcheng: '外观与个性化设置', leixing: '在线文档', xiangmu: '产品手册',
    wendangjieshao: '设置菜单、真暗色模式与本地持久化说明。',
    neirong: `<p>右上角齿轮不再是后台直达入口，而是一个即开即合的设置菜单。</p>
<h2>设置菜单</h2>
<ul><li>外观：亮 / 暗分段切换，暗色为完整变量层的真暗色，而非简单反色；</li><li>减少动效：一键关闭滚动显现、跑马灯与呼吸光晕，低配设备与晕动用户友好；</li><li>默认视图：卡片 / 列表分段，记住你打开文档中心的偏好；</li><li>菜单末项「进入后台」，管理入口收纳但始终在场。</li></ul>
<h2>持久化</h2>
<p>全部设置写入 localStorage，下次打开自动恢复；主胶囊按钮随主题黑白反转，亮暗两态都保证对比度。</p>`
  },
  // 附件文档：保留原文件，仅重写标题与简介为格式示例
  { id: 6, wendangmingcheng: 'PPT 格式上传示例', wendangjieshao: '演示演示文稿上传、类型徽章与下载链路；附件为通用模板文件。' },
  { id: 7, wendangmingcheng: 'Word 格式上传示例', wendangjieshao: '演示 Word 上传与在线正文共存；附件为通用手册文件。' },
  { id: 8, wendangmingcheng: 'Word 拖拽导入示例', wendangjieshao: '演示拖拽 .docx 自动建档与首版历史；附件为通用指引文件。' },
  { id: 9, wendangmingcheng: 'PPT 拖拽导入示例', wendangjieshao: '演示拖拽 .pptx 自动建档与格式徽章；附件为通用汇报文件。' },
  { id: 10, wendangmingcheng: 'Excel 格式上传示例', wendangjieshao: '演示表格附件归档与下载；附件为通用台账文件。' },
  { id: 11, wendangmingcheng: 'Excel 检索筛选示例', wendangjieshao: '演示附件文档参与搜索与类型筛选；附件为通用名单文件。' }
]

const NOTICES = [
  {
    id: 1, gonggaobiaoti: '墨页品牌上线：新图标与视觉语言', faburiqi: '2026-11-24',
    neirong: `<p>平台品牌升级为「墨页」：两字品牌名呼应页面意象，新图标采用薄荷圆角底、折角页文档、环绕轨道与云上传徽章。</p><p>官网与工作台共用同一套设计语言：黑胶囊主按钮、超大黑标题、薄荷网格面板与黑色描边收尾；亮暗双主题可在设置菜单随时切换。</p>`
  },
  {
    id: 6, gonggaobiaoti: '暗色模式与设置菜单上线', faburiqi: '2026-11-23',
    neirong: `<p>右上角齿轮升级为设置菜单：亮暗切换、减少动效、默认视图三项设置本地持久化，菜单末项为后台入口。</p><p>暗色为完整变量层的真暗色，编辑器与表格同步换肤，夜间阅读不再刺眼。</p>`
  },
  {
    id: 2, gonggaobiaoti: 'Markdown 全链路上线', faburiqi: '2026-11-22',
    neirong: `<p>Markdown 导入、编辑、预览、下载四段打通：.md 拖拽即建档，MdEditor 源码写作，MdPreview 纸张式渲染，一键导出当前内容。</p><p>已有 Markdown 资产可无缝迁入，技术文档与手册从此有安静的安放之处。</p>`
  },
  {
    id: 3, gonggaobiaoti: '历史版本功能上线', faburiqi: '2026-11-21',
    neirong: `<p>保存自动快照，单文档保留最近 50 版；历史抽屉支持逐版预览正文与一键恢复，恢复前自动快照，确保每次回退都可追溯。</p><p>误删与误改不再不可逆，版本链就是文档的后悔药。</p>`
  },
  {
    id: 4, gonggaobiaoti: '项目分类功能上线', faburiqi: '2026-11-20',
    neirong: `<p>文档可归属项目，在线文档、Markdown 与 Office 附件跨格式聚合；侧栏实时计数，一键直达项目视图。</p><p>项目筛选与格式筛选、全局搜索可叠加，逐层收窄，沉淀再多也井然有序。</p>`
  },
  {
    id: 5, gonggaobiaoti: '拖拽导入功能上线', faburiqi: '2026-11-19',
    neirong: `<p>文档中心支持整页拖拽：.md 与 Office 文件落页即自动建档，记录格式徽章与首版历史，全程无需点击按钮。</p><p>批量归档旧文件变成一次拖拽的事，迁移成本几乎为零。</p>`
  },
  {
    id: 7, gonggaobiaoti: '附件格式支持说明', faburiqi: '2026-11-18',
    neirong: `<p>平台支持 Word、PPT、Excel 三类 Office 附件上传与下载，拖拽导入自动记录格式与首版历史。</p><p>附件文档可与在线正文共存：正文快速浏览，附件深度阅读与离线流转，各取所需。</p>`
  }
]

async function main() {
  const login = await fetch(`${BASE}/users/login`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: 'username=abo&password=abo'
  }).then(r => r.json())
  if (login.code !== 0) throw new Error('登录失败')
  const h = { 'Content-Type': 'application/json', Token: login.token }

  const docs = (await fetch(`${BASE}/wendangxinxi/page?page=1&limit=1000`, { headers: h }).then(r => r.json())).data.list
  const notices = (await fetch(`${BASE}/gonggaoxinxi/page?page=1&limit=1000`, { headers: h }).then(r => r.json())).data.list

  for (const spec of DOCS) {
    const doc = docs.find(d => String(d.id) === String(spec.id))
    if (!doc) { console.log('缺少文档 id:', spec.id); continue }
    const payload = {
      id: doc.id,
      wendangmingcheng: spec.wendangmingcheng ?? doc.wendangmingcheng,
      leixing: spec.leixing ?? doc.leixing,
      xiangmu: spec.xiangmu ?? (doc.xiangmu || ''),
      wendangjieshao: spec.wendangjieshao ?? doc.wendangjieshao,
      neirong: spec.neirong ?? (doc.neirong || ''),
      neirongmd: doc.neirongmd || '',
      fujian: spec.fujian ?? doc.fujian,
      faburiqi: spec.neirong ? '2026-11-24' : doc.faburiqi
    }
    const res = await fetch(`${BASE}/wendangxinxi/update`, { method: 'POST', headers: h, body: JSON.stringify(payload) }).then(r => r.json())
    console.log('文档:', payload.wendangmingcheng, res.code === 0 ? 'OK' : res)
    if (spec.neirong) {
      const hist = (await fetch(`${BASE}/wendanglishi/page?page=1&limit=100&wendangid=${doc.id}`, { headers: h }).then(r => r.json())).data.list
      if (!hist.some(v => v.beizhu === '内容重写·首版')) {
        await fetch(`${BASE}/wendanglishi/save`, {
          method: 'POST', headers: h,
          body: JSON.stringify({
            wendangid: doc.id, wendangmingcheng: payload.wendangmingcheng, leixing: payload.leixing,
            neirong: payload.neirong, neirongmd: '', xiangmu: payload.xiangmu,
            bianjiren: '访客', beizhu: '内容重写·首版'
          })
        }).then(r => r.json())
        console.log('  历史首版快照 OK')
      }
    }
  }

  for (const spec of NOTICES) {
    const n = notices.find(x => String(x.id) === String(spec.id))
    if (!n) { console.log('缺少公告 id:', spec.id); continue }
    const res = await fetch(`${BASE}/gonggaoxinxi/update`, {
      method: 'POST', headers: h,
      body: JSON.stringify({ id: n.id, gonggaobiaoti: spec.gonggaobiaoti, neirong: spec.neirong, faburiqi: spec.faburiqi, tupian: n.tupian })
    }).then(r => r.json())
    console.log('公告:', spec.gonggaobiaoti, res.code === 0 ? 'OK' : res)
  }

  console.log('演示内容 v3 完成')
}

main().catch(e => { console.error(e); process.exit(1) })