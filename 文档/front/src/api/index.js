import request from './request'

// 文档信息：读写全量接口（正文 neirong 为富文本 HTML）
export const wendangApi = {
  page: (params) => request.get('/wendangxinxi/page', { params }),
  list: () => request.get('/wendangxinxi/list'),
  detail: (id) => request.get(`/wendangxinxi/detail/${id}`),
  add: (data) => request.post('/wendangxinxi/add', data),
  update: (data) => request.post('/wendangxinxi/update', data),
  remove: (ids) => request.post('/wendangxinxi/delete', ids)
}

export const gonggaoApi = {
  page: (params) => request.get('/gonggaoxinxi/page', { params }),
  list: () => request.get('/gonggaoxinxi/list'),
  detail: (id) => request.get(`/gonggaoxinxi/detail/${id}`)
}

// 文档历史版本：每次保存写快照，单篇保留最近 50 版（后端清理）
export const lishiApi = {
  page: (params) => request.get('/wendanglishi/page', { params }),
  info: (id) => request.get(`/wendanglishi/info/${id}`),
  save: (data) => request.post('/wendanglishi/save', data),
  remove: (ids) => request.post('/wendanglishi/delete', ids)
}

// 保存文档后写一条历史快照（正文/Markdown/项目/类型全量快照）
export function saveHistory(doc, { bianjiren = '访客', beizhu = '编辑保存' } = {}) {
  return lishiApi.save({
    wendangid: doc.id,
    wendangmingcheng: doc.wendangmingcheng,
    leixing: doc.leixing,
    neirong: doc.neirong || '',
    neirongmd: doc.neirongmd || '',
    xiangmu: doc.xiangmu || '',
    bianjiren,
    beizhu
  }).catch(e => console.error('历史快照写入失败', e))
}

// 文件上传地址（el-upload / wangEditor 共用）
export const UPLOAD_URL = '/springbootpkh49/file/upload'
export const fileUrl = (name) => `/springbootpkh49/upload/${name}`

// 扩展名 → 文档类型
export function typeByExt(name) {
  const ext = (name.split('.').pop() || '').toLowerCase()
  if (['md', 'markdown'].includes(ext)) return 'Markdown'
  if (['doc', 'docx'].includes(ext)) return 'Word'
  if (['ppt', 'pptx'].includes(ext)) return 'PPT'
  if (['xls', 'xlsx', 'csv'].includes(ext)) return 'Excel'
  if (ext === 'pdf') return 'PDF'
  return '其他'
}

// 文档类型配色：在线文档=品牌绿；Word/PPT/Excel 参照 Office/WPS 官方色（Word 蓝 / PPT 橙红 / Excel 深绿）
export function typeColor(t) {
  const map = { 在线文档: '#00b96b', Markdown: '#595959', Word: '#2b579a', PPT: '#c43e1c', Excel: '#217346', PDF: '#e5484d' }
  return map[t] || '#8c8c8c'
}

// 上传附件文件，返回相对访问路径
export async function uploadFile(file) {
  const fd = new FormData()
  fd.append('file', file)
  const res = await fetch(UPLOAD_URL, {
    method: 'POST',
    headers: { Token: localStorage.getItem('front_token') || '' },
    body: fd
  }).then(r => r.json())
  if (res.code !== 0 || !res.file) throw new Error(res.msg || '上传失败')
  return fileUrl(res.file)
}