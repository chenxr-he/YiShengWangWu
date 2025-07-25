<template>
  <div class="ren-lian-xiao-xiang">
    <!-- 页面标题 -->
    <div class="page-header">
      <h2 class="page-title">人脸肖像</h2>
      <p class="page-description">上传人脸图片，AI 将为您生成精美的艺术肖像画</p>
    </div>

    <!-- 上传区域 -->
    <div class="upload-section">
      <h3 class="section-title">
        <span class="title-icon">👤</span>
        上传人脸图片
      </h3>
      <p class="section-description">请上传清晰的人脸照片，AI 将自动生成艺术风格的肖像画</p>

      <div class="upload-box" @click="handleCustomUpload" :class="{ 'has-image': customImage }">
        <div v-if="!customImage" class="upload-placeholder">
          <div class="upload-icon">📸</div>
          <span class="upload-text">点击上传人脸图片</span>
          <span class="upload-hint">支持 JPG、PNG 格式，建议小于 1MB</span>
        </div>
        <div v-if="customImage" class="image-preview">
          <img :src="customImage" alt="人脸图片" class="uploaded-image" />
          <div class="image-overlay">
            <span class="change-text">点击更换图片</span>
          </div>
        </div>
        <input ref="customFileInput" type="file" id="custom-file-input" class="file-input" @change="handleFileChange" @click.stop accept="image/*" />
      </div>
    </div>

    <!-- 生成按钮 -->
    <div class="action-container">
      <button
        @click="handleGenerate"
        :disabled="!customImage"
        class="generate-button"
        :class="{ 'ready': customImage }"
      >
        <span class="button-icon">🎨</span>
        <span class="button-text">生成艺术肖像</span>
      </button>
    </div>

    <!-- 结果展示区域 -->
    <div class="result-section">
      <!-- 生成的图像 -->
      <div class="image-container" v-if="generatedImage">
        <div class="image-header">
          <h3 class="result-title">
            <span class="title-icon">🖼️</span>
            肖像作品
          </h3>
        </div>
        <div class="image-wrapper">
          <img :src="generatedImage" alt="肖像画" class="generated-image" />
          <div class="image-actions">
            <button class="action-btn download-btn">
              <span>💾</span>
              下载作品
            </button>
            <button class="action-btn regenerate-btn" @click="handleGenerate">
              <span>🔄</span>
              重新生成
            </button>
          </div>
        </div>
      </div>

      <!-- 空状态 -->
      <div class="empty-state" v-else>
        <div class="empty-icon">🎭</div>
        <p class="empty-text">上传人脸图片开始创作</p>
        <p class="empty-hint">AI 将为您创造独特的艺术肖像画</p>
      </div>
    </div>
  </div>
</template>
  
<script>
import { ref } from 'vue'
import { ElMessage } from 'element-plus'
import { BASE_URL } from '../config'
import { SingleFileMaxSize } from '@/GlobalInfo'
export default {
  name: 'RenLianXiaoXiang',
  setup() {
    const customImage = ref(null);  
    const generatedImage = ref(null);  
    const customFile = ref(null);  
    const customFileInput = ref(null);
    
    // 处理上传自定义模特
    const handleCustomUpload = (event) => {
      event.stopPropagation();
      if (!customImage.value ) {
        customFileInput.value.click();
      }
    };

    // 处理文件选择
    const handleFileChange = (event) => {
      const file = event.target.files[0];  // 获取上传的文件
      // 超过1MB的文件不处理
      if (file && file.size > SingleFileMaxSize<<20) {
        ElMessage.warning('文件大小超过限制，请选择小于'+SingleFileMaxSize+'MB的文件');
        return;
      }
      if (file) {
        const reader = new FileReader();
        reader.onload = () => {
          // 设置为图片路径，显示图片
          if (event.target.id === 'custom-file-input') {
            customImage.value = reader.result;
            customFile.value = file;  // 保存原始文件
          } 
        };
        reader.readAsDataURL(file);  // 读取文件为 Data URL 以便显示图片
      }
    };

    // 立刻生成按钮的点击事件
    const handleGenerate = async () => {
      if (!customFile.value) {
        ElMessage.warning('请上传人脸图片');
        return;
      }
      try {
        // 创建 FormData 对象
        const formData1 = new FormData();
        console.log('自定义模特文件', customFile.value.size);
        // 添加文件到 FormData 对象
        formData1.append('custom_image', customFile.value);
        // 具体发送请求
        const response = await fetch(BASE_URL, {
          method: 'POST',
          headers: {
            'type': 'PORTRAIT',
          },
          credentials: 'include',
          body: formData1
        });
        
        console.log(response)
        ElMessage.success('人脸肖像正在生成，请前往历史记录查询...');
      } catch (error) {
        console.error('生成失败', error);
        ElMessage.error('生成肖像失败：' + error.message);
      }
    };
    return {
      customImage,
      generatedImage,
      customFileInput,
      handleCustomUpload,
      handleFileChange,
      handleGenerate,
    }
  }
}
</script>
  
  <style scoped>
.ren-lian-xiao-xiang {
  max-width: 800px;
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

/* 上传区域 */
.upload-section {
  background: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(20px);
  border: 1px solid rgba(102, 126, 234, 0.1);
  border-radius: 20px;
  padding: 32px;
  margin-bottom: 32px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
  text-align: center;
}

.upload-section:hover {
  transform: translateY(-4px);
  box-shadow: 0 12px 40px rgba(102, 126, 234, 0.15);
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
  filter: grayscale(0.3);
}

.section-description {
  font-size: 14px;
  color: #666;
  margin: 0 0 24px 0;
  opacity: 0.8;
}

/* 上传框 */
.upload-box {
  width: 100%;
  max-width: 400px;
  height: 320px;
  margin: 0 auto;
  border: 2px dashed rgba(102, 126, 234, 0.3);
  border-radius: 16px;
  display: flex;
  justify-content: center;
  align-items: center;
  cursor: pointer;
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.02), rgba(118, 75, 162, 0.02));
  position: relative;
  overflow: hidden;
  transition: all 0.3s ease;
}

.upload-box::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(102, 126, 234, 0.1), transparent);
  transition: left 0.5s ease;
}

.upload-box:hover::before {
  left: 100%;
}

.upload-box:hover {
  border-color: #667eea;
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.05), rgba(118, 75, 162, 0.05));
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(102, 126, 234, 0.2);
}

.upload-box.has-image {
  border-color: #667eea;
  background: rgba(255, 255, 255, 0.9);
}

/* 上传占位符 */
.upload-placeholder {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 12px;
  text-align: center;
  z-index: 1;
  position: relative;
}

.upload-icon {
  font-size: 64px;
  opacity: 0.6;
  margin-bottom: 12px;
}

.upload-text {
  font-size: 20px;
  font-weight: 600;
  color: #667eea;
}

.upload-hint {
  font-size: 14px;
  color: #999;
  margin-top: 8px;
}

/* 图片预览 */
.image-preview {
  position: relative;
  width: 100%;
  height: 100%;
  border-radius: 14px;
  overflow: hidden;
}

.uploaded-image {
  width: 100%;
  height: 100%;
  object-fit: contain;
  transition: transform 0.3s ease;
}

.image-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.7);
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: opacity 0.3s ease;
}

.upload-box:hover .image-overlay {
  opacity: 1;
}

.change-text {
  color: white;
  font-size: 16px;
  font-weight: 600;
}

.file-input {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  opacity: 0;
  cursor: pointer;
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

.generate-button:disabled {
  cursor: not-allowed;
  transform: none;
}

.button-icon {
  font-size: 20px;
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

@keyframes pulse {
  0%, 100% {
    opacity: 0.8;
  }
  50% {
    opacity: 1;
  }
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
  .ren-lian-xiao-xiang {
    padding: 0 16px;
  }

  .page-header {
    padding: 24px;
    margin-bottom: 32px;
  }

  .page-title {
    font-size: 28px;
  }

  .upload-section {
    padding: 24px;
  }

  .upload-box {
    height: 280px;
  }

  .upload-icon {
    font-size: 48px;
  }

  .upload-text {
    font-size: 18px;
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

  .upload-section {
    padding: 20px;
  }

  .section-title {
    font-size: 20px;
  }

  .upload-box {
    height: 240px;
  }

  .upload-icon {
    font-size: 40px;
  }

  .upload-text {
    font-size: 16px;
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
  