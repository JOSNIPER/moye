import axios from 'axios'
import { ElMessage } from 'element-plus'
import router from '@/router'

// 统一 baseURL：开发时走 vite 代理，请求 /springbootpkh49/xxx 会被转发到 8080
const request = axios.create({
  baseURL: '/springbootpkh49',
  timeout: 15000
})

// 请求拦截器：自动带上后端的 Token 请求头
request.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('token')
    if (token) {
      config.headers['Token'] = token
    }
    return config
  },
  (error) => Promise.reject(error)
)

// 响应拦截器：后端无论成功失败都返回 HTTP 200，业务码在 body 的 code 里
request.interceptors.response.use(
  (response) => {
    const res = response.data
    // 未登录（后端返回 code:401）
    if (res.code === 401) {
      localStorage.removeItem('token')
      localStorage.removeItem('userInfo')
      ElMessage.error('登录已过期，请重新登录')
      router.push('/login')
      return Promise.reject(new Error('请先登录'))
    }
    // 业务失败（code 非 0）
    if (res.code !== 0 && res.code !== undefined) {
      ElMessage.error(res.msg || '操作失败')
      return Promise.reject(new Error(res.msg || '操作失败'))
    }
    return res
  },
  (error) => {
    ElMessage.error(error.response?.data?.msg || '网络错误，请检查后端是否启动')
    return Promise.reject(error)
  }
)

export default request
