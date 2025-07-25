<template>
  <div class="login-container">
    <!-- 动态SVG背景 -->
    <div class="background-animation">
      <svg class="animated-bg" viewBox="0 0 1200 800" xmlns="http://www.w3.org/2000/svg">
        <defs>
          <linearGradient id="gradient1" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" style="stop-color:#667eea;stop-opacity:1" />
            <stop offset="100%" style="stop-color:#764ba2;stop-opacity:1" />
          </linearGradient>
          <linearGradient id="gradient2" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" style="stop-color:#f093fb;stop-opacity:1" />
            <stop offset="100%" style="stop-color:#f5576c;stop-opacity:1" />
          </linearGradient>
          <linearGradient id="gradient3" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" style="stop-color:#4facfe;stop-opacity:1" />
            <stop offset="100%" style="stop-color:#00f2fe;stop-opacity:1" />
          </linearGradient>
        </defs>

        <!-- 浮动圆形 -->
        <circle class="floating-circle circle1" cx="200" cy="200" r="60" fill="url(#gradient1)" opacity="0.7"/>
        <circle class="floating-circle circle2" cx="800" cy="150" r="80" fill="url(#gradient2)" opacity="0.6"/>
        <circle class="floating-circle circle3" cx="1000" cy="400" r="100" fill="url(#gradient3)" opacity="0.5"/>
        <circle class="floating-circle circle4" cx="300" cy="600" r="70" fill="url(#gradient1)" opacity="0.6"/>
        <circle class="floating-circle circle5" cx="700" cy="700" r="90" fill="url(#gradient2)" opacity="0.4"/>

        <!-- 波浪形状 -->
        <path class="wave wave1" d="M0,400 Q300,300 600,400 T1200,400 L1200,800 L0,800 Z" fill="url(#gradient3)" opacity="0.3"/>
        <path class="wave wave2" d="M0,500 Q400,400 800,500 T1200,500 L1200,800 L0,800 Z" fill="url(#gradient1)" opacity="0.2"/>
      </svg>
    </div>

    <!-- 登录表单 -->
    <div class="login-form-wrapper">
      <el-card class="login-card" shadow="always">
        <div class="login-header">
          <el-icon class="login-icon" :size="40" color="#667eea">
            <User />
          </el-icon>
          <h2 class="login-title">用户登录</h2>
          <p class="login-subtitle">欢迎回到一生万物・AI 图像梦工坊</p>
        </div>

        <el-form
          ref="loginFormRef"
          :model="loginForm"
          :rules="loginRules"
          @submit.prevent="handleLogin"
          size="large"
          class="login-form"
        >
          <el-form-item prop="email">
            <el-input
              v-model="loginForm.email"
              placeholder="请输入邮箱地址"
              :prefix-icon="Message"
              clearable
            />
          </el-form-item>

          <el-form-item prop="password">
            <el-input
              v-model="loginForm.password"
              type="password"
              placeholder="请输入密码"
              :prefix-icon="Lock"
              show-password
              clearable
            />
          </el-form-item>

          <el-form-item>
            <el-button
              type="primary"
              class="login-button"
              :loading="loading"
              @click="handleLogin"
              size="large"
            >
              <el-icon v-if="!loading"><Right /></el-icon>
              {{ loading ? '登录中...' : '立即登录' }}
            </el-button>
          </el-form-item>

          <div class="login-footer">
            <el-link type="primary" @click="goToRegister">
              <el-icon><UserFilled /></el-icon>
              还没有账号？立即注册
            </el-link>

          <!-- 游客登录按钮 -->
          <div class="guest-login">
            <el-button 
              class="guest-button" 
              size="default" 
              @click="loginAsGuest"
              text
            >
              <el-icon><View /></el-icon>
              以游客身份体验
            </el-button>
          </div>

          <!-- 返回首页按钮 -->
          <div class="back-to-home">
            <el-button 
              class="home-button" 
              size="large" 
              @click="goToHome"
              round
            >
              <el-icon><HomeFilled /></el-icon>
              返回首页
            </el-button>
          </div>
          </div>
        </el-form>
      </el-card>
    </div>
  </div>
</template>

<script>
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { User, Message, Lock, Right, UserFilled,HomeFilled,View } from '@element-plus/icons-vue'
import { BASE_URL } from '../config'
import * as Constant from '@/GlobalInfo'
export default {
  name: 'LoginForm',
  setup() {
    const router = useRouter()
    const loginFormRef = ref()
    const loading = ref(false)

    // 表单数据
    const loginForm = reactive({
      email: '',
      password: ''
    })

    // 表单验证规则
    const loginRules = {
      email: [
        { required: true, message: '请输入邮箱地址', trigger: 'blur' },
        { type: 'email', message: '请输入正确的邮箱格式', trigger: 'blur' }
      ],
      password: [
        { required: true, message: '请输入密码', trigger: 'blur' },
        { min: 6, message: '密码长度不能少于6位', trigger: 'blur' }
      ]
    }

    // 登录处理函数
    const handleLogin = async () => {
      if (!loginFormRef.value) return

      await loginFormRef.value.validate(async (valid) => {
        if (valid) {
          loading.value = true
          // 游客登录判断
          const GUEST_EMAIL = 'guest@example.com'
          const GUEST_PASSWORD = '123456'
          // 如果是游客账号，直接登录成功，不请求后端
          if (loginForm.email === GUEST_EMAIL && loginForm.password === GUEST_PASSWORD) {
            try {
              ElMessage.success('游客登录成功！部分功能可能受限')
              
              // 设置游客用户信息
              Constant.userInfo.email = GUEST_EMAIL
              Constant.userInfo.vipStatus = false
              Constant.userInfo.registDate = new Date().toISOString().split('T')[0]
              Constant.userInfo.userID = 'guest-user'
              Constant.userInfo.avatar = '/default-avatar.jpg' // 默认头像路径
              
              // 延迟跳转
              setTimeout(() => {
                router.push('/edit')
              }, 1500)
              
              loading.value = false
              return
            } catch (error) {
              console.error('游客登录错误:', error)
              ElMessage.error('游客登录错误')
              loading.value = false
              return
            }
          }
          // 正常账号登录，请求后端
          try {
            const response = await fetch(BASE_URL, {
                method: 'POST',
                headers: {
                'Content-Type': 'application/json',
                'type': 'Login',            
                },
                body: JSON.stringify({
                  account:  loginForm.email,
                  password: loginForm.password    
                }),

                credentials: 'include',
            });

            const data = await response.json()
            console.log("后端返回的数据：", data)

            if (response.ok && data.status === true) {
              ElMessage.success(data.msg || '登录成功！')

              // 存储用户信息
              Constant.userInfo.email=loginForm.email
              Constant.userInfo.vipStatus=data.vip
              Constant.userInfo.registDate=data.date
              Constant.userInfo.userID=data.userID
              Constant.userInfo.avatar=BASE_URL+data.avatar
              // 延迟跳转，让用户看到成功提示
              setTimeout(() => {
                router.push('/edit')
              }, 1500)
            } else {
              ElMessage.error(data.msg || data.error || '登录失败')
            }
          } catch (error) {
            console.error('登录错误:', error)
            ElMessage.error('登录错误！请检查网络连接或联系管理员')
          } finally {
            loading.value = false
          }
        } else {
          ElMessage.warning('请正确填写登录信息')
        }
      })
    }

    // 跳转到注册页面
    const goToRegister = () => {
      router.push('/register')
    }

    // 添加返回首页的函数
    const goToHome = () => {
      router.push('/')
    }
    // 游客登录函数
    const loginAsGuest = () => {
      loginForm.email = 'guest@example.com'
      loginForm.password = '123456'
      handleLogin()
    }

    return {
      loginFormRef,
      loginForm,
      loginRules,
      loading,
      handleLogin,
      goToRegister,
      goToHome,
      loginAsGuest,
      // 图标
      User,
      Message,
      Lock,
      Right,
      UserFilled,
      HomeFilled,
      View
    }
  },
  mounted() {
    document.body.style.margin = '0'
    document.body.style.padding = '0'
    document.body.style.overflow = 'hidden'
  },
  beforeUnmount() {
    document.body.style.overflow = 'auto'
  }
}
</script>

<style scoped>
.login-container {
  position: relative;
  width: 100vw;
  height: 100vh;
  overflow: hidden;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

/* 动态背景样式 */
.background-animation {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 1;
}

.animated-bg {
  width: 100%;
  height: 100%;
}

/* 浮动圆形动画 */
.floating-circle {
  animation: float 6s ease-in-out infinite;
}

.circle1 {
  animation-delay: 0s;
  animation-duration: 8s;
}

.circle2 {
  animation-delay: 1s;
  animation-duration: 10s;
}

.circle3 {
  animation-delay: 2s;
  animation-duration: 12s;
}

.circle4 {
  animation-delay: 3s;
  animation-duration: 9s;
}

.circle5 {
  animation-delay: 4s;
  animation-duration: 11s;
}

@keyframes float {
  0%, 100% {
    transform: translateY(0px) translateX(0px);
  }
  25% {
    transform: translateY(-20px) translateX(10px);
  }
  50% {
    transform: translateY(-10px) translateX(-15px);
  }
  75% {
    transform: translateY(-30px) translateX(5px);
  }
}

/* 波浪动画 */
.wave {
  animation: wave 8s ease-in-out infinite;
}

.wave1 {
  animation-delay: 0s;
}

.wave2 {
  animation-delay: 2s;
}

@keyframes wave {
  0%, 100% {
    transform: translateX(0px);
  }
  50% {
    transform: translateX(-50px);
  }
}

/* 登录表单容器 */
.login-form-wrapper {
  position: relative;
  z-index: 10;
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100%;
  padding: 20px;
}

.login-card {
  width: 100%;
  max-width: 420px;
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 20px;
  box-shadow: 0 25px 45px rgba(0, 0, 0, 0.1);
  overflow: hidden;
  animation: slideInUp 0.8s ease-out;
}

@keyframes slideInUp {
  from {
    opacity: 0;
    transform: translateY(50px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* 登录头部 */
.login-header {
  text-align: center;
  padding: 40px 30px 20px;
}

.login-icon {
  margin-bottom: 20px;
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.1);
  }
  100% {
    transform: scale(1);
  }
}

.login-title {
  font-size: 28px;
  font-weight: 600;
  color: #2c3e50;
  margin: 0 0 10px 0;
  background: linear-gradient(135deg, #667eea, #764ba2);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.login-subtitle {
  font-size: 14px;
  color: #7f8c8d;
  margin: 0;
  opacity: 0.8;
}

/* 表单样式 */
.login-form {
  padding: 0 30px 30px;
}

.login-form :deep(.el-form-item) {
  margin-bottom: 25px;
}

.login-form :deep(.el-input__wrapper) {
  border-radius: 12px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
  border: 1px solid rgba(102, 126, 234, 0.2);
  transition: all 0.3s ease;
}

.login-form :deep(.el-input__wrapper:hover) {
  border-color: #667eea;
  box-shadow: 0 4px 20px rgba(102, 126, 234, 0.2);
}

.login-form :deep(.el-input__wrapper.is-focus) {
  border-color: #667eea;
  box-shadow: 0 0 0 2px rgba(102, 126, 234, 0.2);
}

.login-button {
  width: 100%;
  height: 50px;
  border-radius: 12px;
  background: linear-gradient(135deg, #667eea, #764ba2);
  border: none;
  font-size: 16px;
  font-weight: 600;
  transition: all 0.3s ease;
  box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
}

.login-button:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(102, 126, 234, 0.5);
}

.login-button:active {
  transform: translateY(0);
}

/* 底部链接 */
.login-footer {
  text-align: center;
  margin-top: 20px;
  padding-top: 20px;
  border-top: 1px solid rgba(0, 0, 0, 0.1);
}

.login-footer :deep(.el-link) {
  font-size: 14px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 5px;
  transition: all 0.3s ease;
  text-decoration: none!important;
}
.login-footer :deep(.el-link::after) {
  display: none!important;;
}

/* 返回首页按钮样式 */
.back-to-home {
  margin-top: 20px;
  display: flex;
  justify-content: center;
}

.home-button {
  background: rgba(255, 255, 255, 0.2);
  border: 2px solid rgba(102, 126, 234, 0.3);
  color: #667eea;
  font-weight: 600;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 10px 25px;
  box-shadow: 0 4px 15px rgba(102, 126, 234, 0.1);
}

.home-button:hover {
  transform: translateY(-2px);
  background: rgba(102, 126, 234, 0.1);
  border-color: #667eea;
  box-shadow: 0 8px 25px rgba(102, 126, 234, 0.2);
}

.home-button:active {
  transform: translateY(0);
}

/* 图标样式 */
.home-button .el-icon {
  font-size: 18px;
  color: #667eea;
}


/* 响应式设计 */
@media (max-width: 480px) {
  .login-form-wrapper {
    padding: 10px;
  }

  .login-card {
    max-width: 100%;
    margin: 0 10px;
  }

  .login-header {
    padding: 30px 20px 15px;
  }

  .login-title {
    font-size: 24px;
  }

  .login-form {
    padding: 0 20px 20px;
  }
}

/* 游客登录按钮样式 */
.guest-login {
  margin-top: 10px;
}

.guest-button {
  color: #667eea;
  transition: all 0.3s;
  font-size: 14px;
}

.guest-button:hover {
  color: #764ba2;
  transform: translateY(-2px);
}

.guest-button .el-icon {
  margin-right: 4px;
}
</style>