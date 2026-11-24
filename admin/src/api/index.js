import request from './request'

// ============ 登录 ============
// 后端 @PostMapping("/users/login") 接收表单参数，不是 JSON
export function login(username, password) {
  const params = new URLSearchParams()
  params.append('username', username)
  params.append('password', password)
  return request.post('/users/login', params)
}

export function logout() {
  return request.get('/users/logout')
}

export function getSession() {
  return request.get('/users/session')
}

// ============ 通用 CRUD 工厂 ============
// 后端每张表都是同一套接口：page / list / info/{id} / save / update / delete
// 用工厂函数生成，避免 8 张表写 8 遍重复代码
export function crudApi(resource) {
  return {
    page: (params) => request.get(`/${resource}/page`, { params }),
    list: (params) => request.get(`/${resource}/list`, { params }),
    info: (id) => request.get(`/${resource}/info/${id}`),
    save: (data) => request.post(`/${resource}/save`, data),
    update: (data) => request.post(`/${resource}/update`, data),
    delete: (ids) => request.post(`/${resource}/delete`, ids)
  }
}

// 8 张业务表
export const bumenApi = crudApi('bumenxinxi')       // 部门信息
export const gangweiApi = crudApi('gangwei')         // 岗位信息
export const gonggaoApi = crudApi('gonggaoxinxi')    // 公告信息
export const wendangApi = crudApi('wendangxinxi')    // 文档信息（核心）
export const yuangongApi = crudApi('yuangong')       // 员工信息
export const usersApi = crudApi('users')             // 用户账号
export const configApi = crudApi('config')           // 系统配置
export const lishiApi = crudApi('wendanglishi')      // 文档历史版本

// ============ 文件上传 ============
export function upload(formData) {
  return request.post('/file/upload', formData, {
    headers: { 'Content-Type': 'multipart/form-data' }
  })
}

// 文档类型配色：与前台一致（在线文档=品牌绿；Word/PPT/Excel 参照 Office/WPS 官方色）
export function typeColor(t) {
  const map = { 在线文档: '#00b96b', Markdown: '#595959', Word: '#2b579a', PPT: '#c43e1c', Excel: '#217346', PDF: '#e5484d' }
  return map[t] || '#8c8c8c'
}
