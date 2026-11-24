import { reactive, watch } from 'vue'

const KEY = 'wb_settings'

/** 工作台偏好设置（localStorage 持久化，全站生效） */
export const settings = reactive({
  theme: 'light',        // light | dark
  reduceMotion: false,   // 减少动效
  defaultView: 'card'    // 文档中心默认视图 card | list
})

export function applySettings() {
  document.documentElement.dataset.theme = settings.theme
  document.body.classList.toggle('reduce-motion', settings.reduceMotion)
}

/** 应用启动时调用一次：读取持久化偏好并监听变更 */
export function initSettings() {
  try {
    const saved = JSON.parse(localStorage.getItem(KEY) || '{}')
    if (saved.theme === 'dark' || saved.theme === 'light') settings.theme = saved.theme
    if (typeof saved.reduceMotion === 'boolean') settings.reduceMotion = saved.reduceMotion
    if (saved.defaultView === 'card' || saved.defaultView === 'list') settings.defaultView = saved.defaultView
  } catch (e) { /* 忽略损坏的本地配置 */ }
  applySettings()
  watch(settings, () => {
    localStorage.setItem(KEY, JSON.stringify(settings))
    applySettings()
  }, { deep: true })
}