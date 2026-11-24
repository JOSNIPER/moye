<template>
  <div class="rich-editor">
    <Toolbar class="editor-toolbar" :editor="editorRef" :defaultConfig="toolbarConfig" mode="default" />
    <Editor class="editor-body" :style="{ height: height }" v-model="innerHtml"
      :defaultConfig="editorConfig" mode="default" @onCreated="onCreated" />
  </div>
</template>

<script setup>
import '@wangeditor/editor/dist/css/style.css'
import { ref, shallowRef, watch, onBeforeUnmount } from 'vue'
import { Editor, Toolbar } from '@wangeditor/editor-for-vue'
import { UPLOAD_URL, fileUrl } from '@/api'

const props = defineProps({
  modelValue: { type: String, default: '' },
  height: { type: String, default: '420px' },
  placeholder: { type: String, default: '开始书写正文…' }
})
const emit = defineEmits(['update:modelValue'])

const editorRef = shallowRef(null)
const innerHtml = ref(props.modelValue || '')

// 外部赋值（如加载详情后回填）时同步进编辑器，避免循环触发
watch(() => props.modelValue, (v) => {
  if (v !== innerHtml.value) innerHtml.value = v || ''
})
watch(innerHtml, (v) => emit('update:modelValue', v))

const toolbarConfig = {
  excludeKeys: ['group-video', 'fullScreen', 'codeBlock', 'emotion']
}

const editorConfig = {
  placeholder: props.placeholder,
  MENU_CONF: {
    uploadImage: {
      server: UPLOAD_URL,
      fieldName: 'file',
      maxFileSize: 10 * 1024 * 1024,
      headers: { Token: localStorage.getItem('front_token') || '' },
      customInsert(res, insertFn) {
        if (res.code === 0 && res.file) insertFn(fileUrl(res.file), res.file, '')
      }
    }
  }
}

function onCreated(editor) { editorRef.value = editor }
onBeforeUnmount(() => { editorRef.value?.destroy() })
</script>

<style scoped>
.rich-editor { border: 1px solid var(--border); border-radius: var(--radius-m); overflow: hidden; background: var(--bg-card); }
.editor-toolbar { border-bottom: 1px solid var(--border-light); }
.editor-body { overflow-y: hidden; }
.rich-editor :deep(.w-e-toolbar) { background: var(--bg-subtle); }
.rich-editor :deep(.w-e-text-container) { font-size: 15px; }
.rich-editor :deep(.w-e-text-container [data-slate-editor]) { padding: 16px 20px; }
</style>