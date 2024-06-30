import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  plugins: [vue()],
  server: {
    proxy: {
      '/stream': {
        target: 'http://localhost:9292',
        changeOrigin: true,
        secure: false,
        ws: true
      }
    }
  }
})
