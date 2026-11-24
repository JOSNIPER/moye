import axios from 'axios'

const BASE = '/springbootpkh49'
const DEMO_USER = { username: 'abo', password: 'abo' }

// 前台是只读展示，但后端接口需要 Token。
// 这里在首次请求前用演示账号静默登录一次，拿到的 token 存本地复用，访客无需手动登录。
let loginPromise = null

async function ensureToken() {
  if (localStorage.getItem('front_token')) return
  if (!loginPromise) {
    loginPromise = axios.post(`${BASE}/users/login`,
      new URLSearchParams(DEMO_USER), { timeout: 10000 })
      .then(res => {
        if (res.data?.code === 0 && res.data.token) {
          localStorage.setItem('front_token', res.data.token)
        }
      })
      .finally(() => { loginPromise = null })
  }
  return loginPromise
}

const request = axios.create({ baseURL: BASE, timeout: 15000 })

request.interceptors.request.use(async (config) => {
  await ensureToken()
  const token = localStorage.getItem('front_token')
  if (token) config.headers['Token'] = token
  return config
})

request.interceptors.response.use(
  async (response) => {
    const res = response.data
    // token 过期（后端返回 code:401）：清除旧 token，静默重新登录后重试一次原请求
    // _retried 标记防止重试仍失败时无限循环
    if (res && res.code === 401 && !response.config._retried) {
      response.config._retried = true
      localStorage.removeItem('front_token')
      await ensureToken()
      return request(response.config)
    }
    return res
  },
  (error) => Promise.reject(error)
)

export default request
