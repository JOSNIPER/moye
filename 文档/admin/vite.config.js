import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import { fileURLToPath, URL } from 'node:url'

export default defineConfig({
  plugins: [vue()],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    }
  },
  server: {
    port: 5173,       // 老师硬性要求：后台地址 5173
    strictPort: true, // 端口被占直接报错，不悄悄顺延，保证老师看到的地址确定
    host: '0.0.0.0',
    proxy: {
      '/springbootpkh49': {
        target: 'http://localhost:8080',
        changeOrigin: true
      }
    }
  },
  preview: {
    port: 5173,
    strictPort: true
  }
})
