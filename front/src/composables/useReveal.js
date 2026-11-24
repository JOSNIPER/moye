import { onMounted, onBeforeUnmount, nextTick } from 'vue'

/**
 * 滚动显现（与官网 Landing 同款 IntersectionObserver reveal）。
 * 列表数据异步刷新后调用 refresh() 重新扫描新增的 .reveal 节点。
 */
export function useReveal() {
  let io = null
  const scan = () => {
    if (!io) return
    document.querySelectorAll('.reveal:not(.in)').forEach(el => io.observe(el))
  }
  onMounted(() => {
    io = new IntersectionObserver((entries) => {
      entries.forEach(en => {
        if (en.isIntersecting) {
          en.target.classList.add('in')
          io.unobserve(en.target)
        }
      })
    }, { threshold: 0.12 })
    nextTick(scan)
  })
  onBeforeUnmount(() => io?.disconnect())
  return { refresh: () => nextTick(scan) }
}

/** 数字滚动（官网 stats countUp 同款，缓出三次方） */
export function countUp(s, dur = 1200) {
  const t0 = performance.now()
  const tick = (t) => {
    const p = Math.min(1, (t - t0) / dur)
    s.display = String(Math.round(s.value * (1 - Math.pow(1 - p, 3))))
    if (p < 1) requestAnimationFrame(tick)
  }
  requestAnimationFrame(tick)
}