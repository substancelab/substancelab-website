import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import path from 'path'

export default defineConfig({
  css: {
    preprocessorOptions: {
      sass: {
        loadPaths: [path.resolve(__dirname, 'frontend')],
      },
    },
  },
  plugins: [
    RubyPlugin(),
  ],
})
