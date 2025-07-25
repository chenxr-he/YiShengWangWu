<template>
  <div class="wen-sheng-tu">
    <!-- 页面标题 -->
    <div class="page-header">
      <h2 class="page-title">文生图</h2>
      <p class="page-description">输入描述文本，AI 将为您生成精美的图像作品</p>
    </div>

    <!-- 输入区域 -->
    <div class="input-section">
      <div class="input-header">
        <h3 class="section-title">
          <span class="title-icon">✍️</span>
          描述您想要的图像
        </h3>
        <p class="input-hint">详细的描述能帮助 AI 生成更准确的图像</p>
      </div>

      <div class="textarea-container">
        <textarea
          v-model="prompt"
          placeholder="例如：一只可爱的橘猫坐在窗台上，阳光透过窗户洒在它身上，背景是蓝天白云..."
          rows="6"
          class="prompt-textarea"
        ></textarea>
        <div class="textarea-footer">
          <span class="char-count">{{ prompt.length }}/500</span>
        </div>
      </div>
    </div>

    <!-- 生成按钮 -->
    <div class="action-container">
      <button
        @click="generateImage"
        :disabled="isLoading || !prompt.trim()"
        class="generate-button"
        :class="{ 'loading': isLoading, 'ready': prompt.trim() && !isLoading }"
      >
        <span class="button-icon">
          <span v-if="isLoading" class="loading-spinner">⏳</span>
          <span v-else>🎨</span>
        </span>
        <span class="button-text">
          {{ isLoading ? '正在生成中...' : '生成图像' }}
        </span>
      </button>
    </div>

    <!-- 结果展示区域 -->
    <div class="result-section">
      <!-- 生成的图像 -->
      <div class="image-container" v-if="imageUrl">
        <div class="image-header">
          <h3 class="result-title">
            <span class="title-icon">🖼️</span>
            生成结果
          </h3>
        </div>
        <div class="image-wrapper">
          <img :src="imageUrl" alt="生成的图像" class="generated-image" />
          <div class="image-actions">
            <button class="action-btn download-btn">
              <span>💾</span>
              下载图片
            </button>
            <button class="action-btn regenerate-btn" @click="generateImage">
              <span>🔄</span>
              重新生成
            </button>
          </div>
        </div>
      </div>

      <!-- 加载状态 -->
      <div class="loading-container" v-else-if="isLoading">
        <div class="loading-animation">
          <div class="loading-dots">
            <span></span>
            <span></span>
            <span></span>
          </div>
          <p class="loading-text">AI 正在创作中，请稍候...</p>
          <p class="loading-tip">通常需要 10-30 秒</p>
        </div>
      </div>

      <!-- 空状态 -->
      <div class="empty-state" v-else>
        <div class="empty-icon">🎭</div>
        <p class="empty-text">输入描述文本开始创作</p>
        <p class="empty-hint">让 AI 为您创造独特的艺术作品</p>
      </div>

    </div>
    
  </div>
</template>

<script>
import { ref } from 'vue'
import { ElMessage } from 'element-plus'
import { BASE_URL } from '../config'

export default {
  name: 'WenShengTu',
  setup() {
    const prompt = ref('');
    const imageUrl = ref('');
    const isLoading = ref(false);
    
    // 生成图像的方法
    const generateImage = async () => {
      if (!prompt.value.trim()) {
        ElMessage.warning('请输入描述文本');
        return;
      }

      isLoading.value = true;

      try {
        console.log('开始生成图像，描述文本:', prompt.value);
        const jsonObject = {'description':prompt.value};
        const jsonString = JSON.stringify(jsonObject);
        console.log(jsonString)
        // 发送请求
        const response = await fetch(BASE_URL, {
          method: 'POST',
          headers: {
            'type': 'WenShengTu',
          },
          credentials: 'include',
          body: jsonString
        });
        console.log(response)
        ElMessage.success("正在生成图像，请前往历史记录查询...")
      } catch (error) {
        console.error('生成图像时出错:', error);
        ElMessage.error('生成图像失败，请稍后重试');
      } finally {
        isLoading.value = false;
      }
    };
    return {
      prompt,
      imageUrl,
      isLoading,
      generateImage
    }
  }
}
</script>

<style scoped>
.wen-sheng-tu {
  max-width: 900px;
  margin: 0 auto;
  padding: 0;
}

/* 页面标题 */
.page-header {
  text-align: center;
  margin-bottom: 48px;
  padding: 32px;
  background: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(20px);
  border: 1px solid rgba(102, 126, 234, 0.1);
  border-radius: 24px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
  position: relative;
  overflow: hidden;
}

.page-header::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 4px;
  background: linear-gradient(90deg, #667eea, #764ba2);
  border-radius: 24px 24px 0 0;
}

.page-title {
  font-size: 32px;
  font-weight: 700;
  color: #333;
  margin: 0 0 16px 0;
  background: linear-gradient(135deg, #667eea, #764ba2);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.page-description {
  font-size: 16px;
  color: #666;
  margin: 0;
  line-height: 1.6;
}

/* 输入区域 */
.input-section {
  background: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(20px);
  border: 1px solid rgba(102, 126, 234, 0.1);
  border-radius: 20px;
  padding: 32px;
  margin-bottom: 32px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
}

.input-section:hover {
  transform: translateY(-2px);
  box-shadow: 0 12px 40px rgba(102, 126, 234, 0.15);
}

.input-header {
  text-align: center;
  margin-bottom: 24px;
}

.section-title {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
  font-size: 22px;
  font-weight: 600;
  color: #333;
  margin: 0 0 12px 0;
}

.title-icon {
  font-size: 24px;
  filter: grayscale(0.2);
}

.input-hint {
  font-size: 14px;
  color: #666;
  margin: 0;
  opacity: 0.8;
}

.textarea-container {
  position: relative;
}

.prompt-textarea {
  width: 100%;
  padding: 20px;
  border: 2px solid rgba(102, 126, 234, 0.2);
  border-radius: 16px;
  font-size: 16px;
  line-height: 1.6;
  resize: vertical;
  background: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(10px);
  transition: all 0.3s ease;
  font-family: inherit;
  box-sizing: border-box;
}

.prompt-textarea:focus {
  outline: none;
  border-color: #667eea;
  box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
  background: rgba(255, 255, 255, 0.95);
}

.prompt-textarea::placeholder {
  color: #999;
  font-style: italic;
}

.textarea-footer {
  display: flex;
  justify-content: flex-end;
  margin-top: 8px;
}

.char-count {
  font-size: 12px;
  color: #999;
  padding: 4px 8px;
  background: rgba(102, 126, 234, 0.1);
  border-radius: 12px;
}

/* 操作按钮 */
.action-container {
  display: flex;
  justify-content: center;
  margin-bottom: 48px;
}

.generate-button {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 16px 32px;
  font-size: 18px;
  font-weight: 600;
  border: none;
  border-radius: 25px;
  cursor: pointer;
  background: linear-gradient(135deg, #cccccc, #999999);
  color: white;
  transition: all 0.3s ease;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
  position: relative;
  overflow: hidden;
  min-width: 200px;
}

.generate-button::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
  transition: left 0.5s ease;
}

.generate-button.ready {
  background: linear-gradient(135deg, #667eea, #764ba2);
  box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
}

.generate-button.ready:hover::before {
  left: 100%;
}

.generate-button.ready:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(102, 126, 234, 0.5);
}

.generate-button.loading {
  background: linear-gradient(135deg, #667eea, #764ba2);
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0%, 100% {
    opacity: 1;
  }
  50% {
    opacity: 0.8;
  }
}

.generate-button:disabled {
  cursor: not-allowed;
  transform: none;
}

.button-icon {
  font-size: 20px;
  display: flex;
  align-items: center;
}

.loading-spinner {
  animation: spin 1s linear infinite;
}

@keyframes spin {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}

.button-text {
  font-size: 16px;
}

/* 结果展示区域 */
.result-section {
  min-height: 200px;
}

/* 图像容器 */
.image-container {
  background: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(20px);
  border: 1px solid rgba(102, 126, 234, 0.1);
  border-radius: 20px;
  padding: 32px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
  animation: slideInUp 0.5s ease-out;
}

@keyframes slideInUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.image-header {
  text-align: center;
  margin-bottom: 24px;
}

.result-title {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
  font-size: 22px;
  font-weight: 600;
  color: #333;
  margin: 0;
}

.image-wrapper {
  text-align: center;
  position: relative;
}

.generated-image {
  max-width: 100%;
  max-height: 500px;
  border-radius: 16px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
  transition: transform 0.3s ease;
  cursor: pointer;
}

.generated-image:hover {
  transform: scale(1.02);
}

.image-actions {
  display: flex;
  justify-content: center;
  gap: 16px;
  margin-top: 24px;
}

.action-btn {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 12px 20px;
  border: none;
  border-radius: 20px;
  cursor: pointer;
  font-size: 14px;
  font-weight: 500;
  transition: all 0.3s ease;
  backdrop-filter: blur(10px);
}

.download-btn {
  background: linear-gradient(135deg, #4CAF50, #45a049);
  color: white;
  box-shadow: 0 4px 15px rgba(76, 175, 80, 0.3);
}

.download-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(76, 175, 80, 0.4);
}

.regenerate-btn {
  background: rgba(102, 126, 234, 0.1);
  color: #667eea;
  border: 2px solid rgba(102, 126, 234, 0.2);
}

.regenerate-btn:hover {
  background: rgba(102, 126, 234, 0.2);
  transform: translateY(-2px);
}

/* 加载状态 */
.loading-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 300px;
  background: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(20px);
  border: 1px solid rgba(102, 126, 234, 0.1);
  border-radius: 20px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
}

.loading-animation {
  text-align: center;
}

.loading-dots {
  display: flex;
  justify-content: center;
  gap: 8px;
  margin-bottom: 20px;
}

.loading-dots span {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background: linear-gradient(135deg, #667eea, #764ba2);
  animation: bounce 1.4s ease-in-out infinite both;
}

.loading-dots span:nth-child(1) {
  animation-delay: -0.32s;
}

.loading-dots span:nth-child(2) {
  animation-delay: -0.16s;
}

@keyframes bounce {
  0%, 80%, 100% {
    transform: scale(0);
  }
  40% {
    transform: scale(1);
  }
}

.loading-text {
  font-size: 18px;
  font-weight: 600;
  color: #667eea;
  margin: 0 0 8px 0;
}

.loading-tip {
  font-size: 14px;
  color: #999;
  margin: 0;
}

/* 空状态 */
.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 300px;
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.05), rgba(118, 75, 162, 0.05));
  border: 2px dashed rgba(102, 126, 234, 0.3);
  border-radius: 20px;
  animation: pulse 3s infinite;
}

.empty-icon {
  font-size: 64px;
  margin-bottom: 16px;
  opacity: 0.6;
}

.empty-text {
  font-size: 18px;
  font-weight: 600;
  color: #667eea;
  margin: 0 0 8px 0;
}

.empty-hint {
  font-size: 14px;
  color: #999;
  margin: 0;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .wen-sheng-tu {
    padding: 0 16px;
  }

  .page-header {
    padding: 24px;
    margin-bottom: 32px;
  }

  .page-title {
    font-size: 28px;
  }

  .input-section {
    padding: 24px;
  }

  .prompt-textarea {
    padding: 16px;
    font-size: 15px;
  }

  .generate-button {
    padding: 14px 28px;
    font-size: 16px;
    min-width: 180px;
  }

  .image-actions {
    flex-direction: column;
    gap: 12px;
  }

  .action-btn {
    width: 100%;
    justify-content: center;
  }
}

@media (max-width: 480px) {
  .page-header {
    padding: 20px;
  }

  .page-title {
    font-size: 24px;
  }

  .input-section {
    padding: 20px;
  }

  .section-title {
    font-size: 20px;
  }

  .prompt-textarea {
    padding: 14px;
    font-size: 14px;
  }

  .generate-button {
    padding: 12px 24px;
    font-size: 15px;
    min-width: 160px;
  }

  .empty-icon {
    font-size: 48px;
  }

  .empty-text {
    font-size: 16px;
  }
}
</style>
