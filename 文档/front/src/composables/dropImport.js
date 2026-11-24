import { ref } from 'vue'
import { ElMessage } from 'element-plus'
import { wendangApi, saveHistory, uploadFile, typeByExt } from '@/api'

/**
 * 拖拽导入：.md/.markdown 读文本直接建在线 Markdown 文档；
 * 其他格式走 /file/upload 建附件文档。返回拖拽状态与事件绑定。
 */
export function useDropImport(onDone) {
  const dragging = ref(false)
  let depth = 0

  const isMd = (f) => /\.(md|markdown)$/i.test(f.name)

  async function importFiles(files) {
    const list = Array.from(files || [])
    if (!list.length) return
    let ok = 0
    for (const file of list) {
      try {
        const title = file.name.replace(/\.[^.]+$/, '')
        const today = new Date().toISOString().slice(0, 10)
        let payload
        if (isMd(file)) {
          const text = await file.text()
          payload = {
            wendangmingcheng: title, leixing: 'Markdown',
            neirongmd: text, neirong: ' ', fujian: '', faburiqi: today,
            wendangjieshao: `由 ${file.name} 导入`
          }
        } else {
          const url = await uploadFile(file)
          payload = {
            wendangmingcheng: title, leixing: typeByExt(file.name),
            neirong: ' ', neirongmd: ' ', fujian: url, faburiqi: today,
            wendangjieshao: `由 ${file.name} 拖拽导入`
          }
        }
        const res = await wendangApi.add(payload)
        if (res.code === 0) {
          ok++
          // 新建也记一条历史（后端 add 不返回 id，按名称+时间取最新一条）
          const q = await wendangApi.page({ page: 1, limit: 1, wendangmingcheng: title, sidx: 'id', order: 'DESC' })
          const created = q.data?.list?.[0]
          if (created) saveHistory(created, { beizhu: isMd(file) ? 'Markdown 导入' : '附件拖拽导入' })
        } else ElMessage.error(res.msg || `导入 ${file.name} 失败`)
      } catch (e) {
        ElMessage.error(`导入 ${file.name} 失败：${e.message}`)
      }
    }
    if (ok) ElMessage.success(`成功导入 ${ok} 个文件`)
    onDone && onDone(ok)
  }

  function onDragEnter(e) {
    if (!e.dataTransfer?.types?.includes('Files')) return
    depth++
    dragging.value = true
  }
  function onDragLeave() {
    depth = Math.max(0, depth - 1)
    if (!depth) dragging.value = false
  }
  function onDragOver(e) {
    if (e.dataTransfer?.types?.includes('Files')) e.preventDefault()
  }
  function onDrop(e) {
    depth = 0
    dragging.value = false
    if (!e.dataTransfer?.files?.length) return
    e.preventDefault()
    importFiles(e.dataTransfer.files)
  }

  return { dragging, importFiles, onDragEnter, onDragLeave, onDragOver, onDrop }
}