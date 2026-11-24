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

const props = defineProps({
  modelValue: { type: String, default: '' },
  height: { type: String, default: '320px' },
  placeholder: { type: String, default: '请输入内容…' }
})
const emit = defineEmits(['update:modelValue'])

const editorRef = shallowRef(null)
const innerHtml = ref(props.modelValue || '')

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
      server: '/springbootpkh49/file/upload',
      fieldName: 'file',
      maxFileSize: 10 * 1024 * 1024,
      headers: { Token: localStorage.getItem('token') || '' },
      customInsert(res, insertFn) {
        if (res.code === 0 && res.file) insertFn(`/springbootpkh49/upload/${res.file}`, res.file, '')
      }
    }
  }
}

function onCreated(editor) { editorRef.value = editor }
onBeforeUnmount(() => { editorRef.value?.destroy() })
</script>

<style scoped>
.rich-editor { border: 1px solid var(--border); border-radius: var(--radius-m); overflow: hidden; background: #fff; width: 100%; }
.editor-toolbar { border-bottom: 1px solid var(--border-light); }
.editor-body { overflow-y: hidden; }
.rich-editor :deep(.w-e-toolbar) { background: var(--bg-subtle); }
.rich-editor :deep(.w-e-text-container) { font-size: 14px; }
.rich-editor :deep(.w-e-text-container [data-slate-editor]) { padding: 12px 16px; }
</style>