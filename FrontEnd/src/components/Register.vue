<template>
  <div class="register-container">
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
        <circle class="floating-circle circle1" cx="300" cy="150" r="70" fill="url(#gradient2)" opacity="0.6"/>
        <circle class="floating-circle circle2" cx="900" cy="200" r="90" fill="url(#gradient1)" opacity="0.7"/>
        <circle class="floating-circle circle3" cx="150" cy="500" r="60" fill="url(#gradient3)" opacity="0.5"/>
        <circle class="floating-circle circle4" cx="1050" cy="600" r="80" fill="url(#gradient2)" opacity="0.4"/>
        <circle class="floating-circle circle5" cx="600" cy="100" r="100" fill="url(#gradient3)" opacity="0.6"/>

        <!-- 波浪形状 -->
        <path class="wave wave1" d="M0,350 Q400,250 800,350 T1200,350 L1200,800 L0,800 Z" fill="url(#gradient1)" opacity="0.3"/>
        <path class="wave wave2" d="M0,450 Q300,350 600,450 T1200,450 L1200,800 L0,800 Z" fill="url(#gradient2)" opacity="0.2"/>
      </svg>
    </div>

    <!-- 注册表单 -->
    <div class="register-form-wrapper">
      <el-card class="register-card" shadow="always">
        <div class="register-header">
          <el-icon class="register-icon" :size="40" color="#667eea">
            <UserFilled />
          </el-icon>
          <h2 class="register-title">用户注册</h2>
          <p class="register-subtitle">加入一生万物・AI 图像梦工坊</p>
        </div>

        <el-form
          ref="registerFormRef"
          :model="registerForm"
          :rules="registerRules"
          @submit.prevent="handleRegister"
          size="large"
          class="register-form"
        >
          <el-form-item prop="username">
            <el-input
              v-model="registerForm.username"
              placeholder="请输入用户名"
              :prefix-icon="User"
              clearable
            />
          </el-form-item>

          <el-form-item prop="email">
            <el-input
              v-model="registerForm.email"
              placeholder="请输入邮箱地址"
              :prefix-icon="Message"
              clearable
            />
          </el-form-item>

          <el-form-item prop="password">
            <el-input
              v-model="registerForm.password"
              type="password"
              placeholder="请输入密码"
              :prefix-icon="Lock"
              show-password
              clearable
            />
          </el-form-item>

          <el-form-item prop="confirmPassword">
            <el-input
              v-model="registerForm.confirmPassword"
              type="password"
              placeholder="请确认密码"
              :prefix-icon="Lock"
              show-password
              clearable
            />
          </el-form-item>
          <el-form-item prop="verifyCode">
            <div style="display: flex; gap: 8px; width: 100%;">
              <el-input
                v-model="registerForm.verifyCode"
                placeholder="请输入验证码"
                clearable
                style="flex: 1; min-width: 0;"  
              />
              <el-button
                type="primary"
                @click="getVerifyCode"
                :disabled="countdown > 0"
                style="min-width: 100px;"
              >
                {{ countdown > 0 ? `${countdown}秒后重试` : '获取验证码' }}
              </el-button>
            </div>
          </el-form-item>
          <el-form-item>
            <el-button
              type="primary"
              class="register-button"
              :loading="loading"
              @click="handleRegister"
              size="large"
            >
              <el-icon v-if="!loading"><Check /></el-icon>
              {{ loading ? '注册中...' : '立即注册' }}
            </el-button>
          </el-form-item>

          <div class="register-footer">
            <el-link type="primary" @click="goToLogin">
              <el-icon><Right /></el-icon>
              已有账号？立即登录
            </el-link>

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
import { ref, reactive, onBeforeUnmount } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { User, Message, Lock, UserFilled, Check, Right,HomeFilled } from '@element-plus/icons-vue'
import { BASE_URL } from '../config'

export default {
  name: 'RegisterForm',
  setup() {
    const router = useRouter()
    const registerFormRef = ref()
    const loading = ref(false)
    const countdown = ref(0)
    let countdownTimer = null

    // 表单数据
    const registerForm = reactive({
      username: '',
      email: '',
      password: '',
      confirmPassword: '',
      verifyCode:''
    })

    // 验证函数
    const validateConfirmPassword = (_, value, callback) => {
      if (value === '') {
        callback(new Error('请再次输入密码'))
      } else if (value !== registerForm.password) {
        callback(new Error('两次输入密码不一致'))
      } else {
        callback()
      }
    }

    // 表单验证规则
    const registerRules = {
      username: [
        { required: true, message: '请输入用户名', trigger: 'blur' },
        { min: 2, max: 20, message: '用户名长度在 2 到 20 个字符', trigger: 'blur' }
      ],
      email: [
        { required: true, message: '请输入邮箱地址', trigger: 'blur' },
        { type: 'email', message: '请输入正确的邮箱格式', trigger: 'blur' }
      ],
      password: [
        { required: true, message: '请输入密码', trigger: 'blur' },
        { min: 6, message: '密码长度不能少于6位', trigger: 'blur' }
      ],
      confirmPassword: [
        { required: true, message: '请确认密码', trigger: 'blur' },
        { validator: validateConfirmPassword, trigger: 'blur' }
      ],
      verifyCode:[
        {message:'请输入验证码',trigger:'blur'},
        {min:5,max:5,message:'验证码必须为5位',trigger:'blur'}
      ]
    }
    // 开始倒计时
    const startCountdown = () => {
      countdown.value = 60
      countdownTimer = setInterval(() => {
        countdown.value--
        if (countdown.value <= 0) {
          clearInterval(countdownTimer)
          countdownTimer = null
        }
      }, 1000)
    }

    const getVerifyCode=async()=>{
        if (!registerFormRef.value) return
        if (countdown.value > 0) return // 如果正在倒计时，直接返回

        // 只验证邮箱字段
        await registerFormRef.value.validateField('email', async (valid) => {
          if (valid){
              try{
                const resp=await fetch(BASE_URL,{
                  method:'GET',
                  headers:{
                    'type': 'RegistVerityCode',
                    'account': registerForm.email,
                  }
                })
                  const data=await resp.json()
                  const msg=data["msg"]
                  const status=data["status"]
                  if(status===false){
                    ElMessage.error('获取失败!'+msg)
                  }else{
                    ElMessage.success(msg)
                    // 验证码发送成功后开始倒计时
                    startCountdown()
                  }
              }catch(error){
                console.error('验证码发送错误:', error)
                ElMessage.error('验证码发送失败，请稍后重试')
              }
            }
        })
    }
    // 注册处理函数
    const handleRegister = async () => {
      if (!registerFormRef.value) return

      await registerFormRef.value.validate(async (valid) => {
        if (valid) {
          loading.value = true
          try {
            const response = await fetch(BASE_URL, {
              method: 'POST',
              headers: {
                'Content-Type': 'application/json',
                'type': 'Regist',
              },
              body: JSON.stringify({
                userID: registerForm.username,
                account:registerForm.email,
                password: registerForm.password,
                verifyCode:registerForm.verifyCode,
              })
            })

            const data = await response.json()
            console.log("后端返回的数据：", data)
            if (response.ok && data.status === true) {
              ElMessage.success(data.msg || '注册成功！')

              // 清空表单
              registerForm.username = ''
              registerForm.email = ''
              registerForm.password = ''
              registerForm.confirmPassword = ''
              registerForm.verifyCode=''
              // 延迟跳转到登录页面
              setTimeout(() => {
                router.push('/login')
              }, 1500)
            } else {
              ElMessage.error(data.msg || data.error || '注册失败')
            }
          } catch (error) {
            console.error('注册错误:', error)
            ElMessage.error('注册失败！请检查网络连接或联系管理员')
          } finally {
            loading.value = false
          }
        } else {
          ElMessage.warning('请正确填写注册信息')
        }
      })
    }

    // 跳转到登录页面
    const goToLogin = () => {
      router.push('/login')
    }

    // 组件销毁时清理定时器
    onBeforeUnmount(() => {
      if (countdownTimer) {
        clearInterval(countdownTimer)
        countdownTimer = null
      }
    })

    // 返回首页的函数
    const goToHome = () => {
      router.push('/')
    }

    return {
      registerFormRef,
      registerForm,
      registerRules,
      loading,
      countdown,
      getVerifyCode,
      handleRegister,
      goToLogin,
      goToHome,
      // 图标
      User,
      Message,
      Lock,
      UserFilled,
      Check,
      Right,
      HomeFilled
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
.register-container {
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
  animation-delay: 0.5s;
  animation-duration: 9s;
}

.circle2 {
  animation-delay: 1.5s;
  animation-duration: 11s;
}

.circle3 {
  animation-delay: 2.5s;
  animation-duration: 7s;
}

.circle4 {
  animation-delay: 3.5s;
  animation-duration: 10s;
}

.circle5 {
  animation-delay: 4.5s;
  animation-duration: 8s;
}

@keyframes float {
  0%, 100% {
    transform: translateY(0px) translateX(0px) rotate(0deg);
  }
  25% {
    transform: translateY(-25px) translateX(15px) rotate(90deg);
  }
  50% {
    transform: translateY(-15px) translateX(-20px) rotate(180deg);
  }
  75% {
    transform: translateY(-35px) translateX(8px) rotate(270deg);
  }
}

/* 波浪动画 */
.wave {
  animation: wave 10s ease-in-out infinite;
}

.wave1 {
  animation-delay: 1s;
}

.wave2 {
  animation-delay: 3s;
}

@keyframes wave {
  0%, 100% {
    transform: translateX(0px) scaleY(1);
  }
  50% {
    transform: translateX(-30px) scaleY(1.1);
  }
}

/* 注册表单容器 */
.register-form-wrapper {
  position: relative;
  z-index: 10;
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100%;
  padding: 20px;
}

.register-card {
  width: 100%;
  max-width: 450px;
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
    transform: translateY(50px) scale(0.9);
  }
  to {
    opacity: 1;
    transform: translateY(0) scale(1);
  }
}

/* 注册头部 */
.register-header {
  text-align: center;
  padding: 40px 30px 20px;
}

.register-icon {
  margin-bottom: 20px;
  animation: bounce 2s infinite;
}

@keyframes bounce {
  0%, 20%, 50%, 80%, 100% {
    transform: translateY(0);
  }
  40% {
    transform: translateY(-10px);
  }
  60% {
    transform: translateY(-5px);
  }
}

.register-title {
  font-size: 28px;
  font-weight: 600;
  color: #2c3e50;
  margin: 0 0 10px 0;
  background: linear-gradient(135deg, #667eea, #764ba2);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.register-subtitle {
  font-size: 14px;
  color: #7f8c8d;
  margin: 0;
  opacity: 0.8;
}

/* 表单样式 */
.register-form {
  padding: 0 30px 30px;
}

.register-form :deep(.el-form-item) {
  margin-bottom: 20px;
}

.register-form :deep(.el-input__wrapper) {
  border-radius: 12px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
  border: 1px solid rgba(102, 126, 234, 0.2);
  transition: all 0.3s ease;
}

.register-form :deep(.el-input__wrapper:hover) {
  border-color: #667eea;
  box-shadow: 0 4px 20px rgba(102, 126, 234, 0.2);
  transform: translateY(-1px);
}

.register-form :deep(.el-input__wrapper.is-focus) {
  border-color: #667eea;
  box-shadow: 0 0 0 2px rgba(102, 126, 234, 0.2);
  transform: translateY(-1px);
}

.register-button {
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

.register-button:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(102, 126, 234, 0.5);
}

.register-button:active {
  transform: translateY(0);
}

/* 底部链接 */
.register-footer {
  text-align: center;
  margin-top: 20px;
  padding-top: 20px;
  border-top: 1px solid rgba(0, 0, 0, 0.1);
}

.register-footer :deep(.el-link) {
  font-size: 14px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 5px;
  transition: all 0.3s ease;
  text-decoration: none;
}
.register-footer  :deep(.el-link::after) {
  display: none!important;;
}

/* 返回首页按钮 */
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
  .register-form-wrapper {
    padding: 10px;
  }

  .register-card {
    max-width: 100%;
    margin: 0 10px;
  }

  .register-header {
    padding: 30px 20px 15px;
  }

  .register-title {
    font-size: 24px;
  }

  .register-form {
    padding: 0 20px 20px;
  }
}
</style>
