const { defineConfig } = require('@vue/cli-service')
const fs = require('fs')
module.exports = defineConfig({
  transpileDependencies: true,

  devServer: {
    https: {
      key: fs.readFileSync('ssl/key.pem'),
      cert: fs.readFileSync('ssl/cert.pem')
    },
    proxy: {
      '/api': {
        target: 'https://www.adhn.asia:2222', // 代理目标
        changeOrigin: true,  // 是否改变请求头中的 origin
        pathRewrite: {
          '^/api': '',  // 重写路径，去掉 /api 部分
        },
      },
    },
  },
})
