<template>
  <div class="home-container">
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
        <circle class="floating-circle circle1" cx="200" cy="120" r="60" fill="url(#gradient2)" opacity="0.6"/>
        <circle class="floating-circle circle2" cx="1000" cy="180" r="80" fill="url(#gradient1)" opacity="0.7"/>
        <circle class="floating-circle circle3" cx="100" cy="450" r="50" fill="url(#gradient3)" opacity="0.5"/>
        <circle class="floating-circle circle4" cx="1100" cy="550" r="70" fill="url(#gradient2)" opacity="0.4"/>
        <circle class="floating-circle circle5" cx="500" cy="80" r="90" fill="url(#gradient3)" opacity="0.6"/>
        <circle class="floating-circle circle6" cx="800" cy="650" r="65" fill="url(#gradient1)" opacity="0.5"/>

        <!-- 波浪形状 -->
        <path class="wave wave1" d="M0,400 Q400,300 800,400 T1200,400 L1200,800 L0,800 Z" fill="url(#gradient1)" opacity="0.3"/>
        <path class="wave wave2" d="M0,500 Q300,400 600,500 T1200,500 L1200,800 L0,800 Z" fill="url(#gradient2)" opacity="0.2"/>
      </svg>
    </div>

    <!-- 主要内容 -->
    <div class="home-content">
      <!-- 主标题和描述 -->
      <div class="hero-section">
        <div class="hero-content">
          <h1 class="main-title">
            <span class="title-highlight">一生万物</span>・AI 图像梦工坊
          </h1>
          <p class="main-description">
            AI 解锁创意魔法，在梦工坊造万物！<br>
            虚拟换衣秒变风格达人，文生图让想象落地成画<br>
            人脸风格化、肖像重塑玩出专属个性，智能抠图一键焕新<br>
            来这里，让每个创意都开花！
          </p>

          <!-- 主要操作按钮 -->
          <div class="action-buttons">
            <el-button type="primary" size="large" class="primary-action-btn" @click="goToLogin">
              <el-icon><User /></el-icon>
              登录
            </el-button>
            <el-button type="default" size="large" class="secondary-action-btn" @click="goToRegister">
              <el-icon><UserFilled /></el-icon>
              注册
            </el-button>
          </div>
        </div>
      </div>
      <!-- 添加作者署名 -->
      <div class="author-credits">
        <p>作者：汪立洪，陈旭冉，张展翼</p>
      </div>
    </div>
  </div>
</template>

<script>
import { useRouter } from 'vue-router'
import { onMounted, onBeforeUnmount } from 'vue'
import { User, UserFilled } from '@element-plus/icons-vue'

export default {
  name: 'HomeA',
  setup() {
    const router = useRouter()

    const goToLogin = () => {
      router.push('/login')
    }

    const goToRegister = () => {
      router.push('/register')
    }

    onMounted(() => {
      document.body.style.margin = '0'
      document.body.style.padding = '0'
      document.body.style.overflow = 'hidden'
    })

    onBeforeUnmount(() => {
      document.body.style.overflow = 'auto'
    })

    return {
      goToLogin,
      goToRegister,
      User,
      UserFilled
    }
  }
}
</script>

<style scoped>
.home-container {
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

.circle6 {
  animation-delay: 5.5s;
  animation-duration: 12s;
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

/* 主要内容容器 */
.home-content {
  position: relative;
  z-index: 10;
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
}

/* 主要内容区域 */
.hero-section {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0 50px;
  text-align: center;
}

.hero-content {
  max-width: 800px;
  animation: slideInUp 1s ease-out;
}

/* 主标题 */
.main-title {
  font-size: 3.5rem;
  font-weight: 700;
  color: white;
  margin: 0 0 30px 0;
  line-height: 1.2;
  text-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
}

.title-highlight {
  background: linear-gradient(135deg, #f093fb, #f5576c);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  position: relative;
}

.title-highlight::after {
  content: '';
  position: absolute;
  bottom: -5px;
  left: 0;
  right: 0;
  height: 3px;
  background: linear-gradient(135deg, #f093fb, #f5576c);
  border-radius: 2px;
  opacity: 0.7;
}

/* 主描述 */
.main-description {
  font-size: 1.3rem;
  color: rgba(255, 255, 255, 0.9);
  line-height: 1.8;
  margin: 0 0 50px 0;
  text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
  font-weight: 400;
}

/* 操作按钮 */
.action-buttons {
  display: flex;
  gap: 20px;
  justify-content: center;
  flex-wrap: wrap;
}

.primary-action-btn {
  background: linear-gradient(135deg, #667eea, #764ba2);
  border: none;
  border-radius: 50px;
  padding: 18px 40px;
  font-size: 18px;
  font-weight: 600;
  color: white;
  transition: all 0.3s ease;
  box-shadow: 0 8px 30px rgba(102, 126, 234, 0.4);
}

.primary-action-btn:hover {
  transform: translateY(-3px);
  box-shadow: 0 12px 40px rgba(102, 126, 234, 0.6);
  background: linear-gradient(135deg, #7c8ef0, #8a5bb8);
}

.secondary-action-btn {
  background: rgba(255, 255, 255, 0.15);
  border: 2px solid rgba(255, 255, 255, 0.3);
  border-radius: 50px;
  padding: 18px 40px;
  font-size: 18px;
  font-weight: 600;
  color: white;
  transition: all 0.3s ease;
  backdrop-filter: blur(10px);
}

.secondary-action-btn:hover {
  background: rgba(255, 255, 255, 0.25);
  transform: translateY(-3px);
  box-shadow: 0 12px 40px rgba(255, 255, 255, 0.2);
}

/* 作者署名样式 */
.author-credits {
  position: absolute;
  bottom: 20px;
  left: 0;
  right: 0;
  text-align: center;
  z-index: 20;
  opacity: 0.7;
  transition: opacity 0.3s ease;
}

.author-credits:hover {
  opacity: 0.9;
}

.author-credits p {
  font-size: 16px;
  color: rgba(255, 255, 255, 0.8);
  font-weight: 300;
  margin: 0;
  letter-spacing: 1px;
  text-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
  font-family: 'PingFang SC', 'Helvetica Neue', Arial, sans-serif;
  backdrop-filter: blur(5px);
  background-color: rgba(0, 0, 0, 0.05);
  display: inline-block;
  padding: 6px 15px;
  border-radius: 20px;
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


/* 响应式设计 */
@media (max-width: 768px) {
  .hero-section {
    padding: 0 30px;
  }

  .main-title {
    font-size: 2.5rem;
    margin-bottom: 20px;
  }

  .main-description {
    font-size: 1.1rem;
    margin-bottom: 40px;
  }

  .action-buttons {
    flex-direction: column;
    align-items: center;
    gap: 15px;
  }

  .primary-action-btn,
  .secondary-action-btn {
    width: 100%;
    max-width: 280px;
    padding: 16px 32px;
    font-size: 16px;
  }
}

@media (max-width: 480px) {
  .hero-section {
    padding: 0 20px;
  }

  .main-title {
    font-size: 2rem;
  }

  .main-description {
    font-size: 1rem;
  }

  .auth-buttons {
    position: relative;
    top: 20px;
    right: auto;
    justify-content: center;
    margin-bottom: 20px;
  }
}
</style>
  