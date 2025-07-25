<template>
  <div class="xu-ni-huan-yi">
    <!-- 页面标题 -->
    <div class="page-header">
      <h2 class="page-title">虚拟换衣</h2>
      <p class="page-description">上传模特和服装图片，AI 将为您生成虚拟换衣效果</p>
    </div>

    <!-- 上传区域 -->
    <div class="upload-container">
      <!-- 上传自定义模特 -->
      <div class="upload-section">
        <h3 class="section-title">
          <span class="title-icon">👤</span>
          上传模特图片
        </h3>
        <div class="upload-box" @click="handleCustomUpload" :class="{ 'has-image': customImage }">
          <div v-if="!customImage" class="upload-placeholder">
            <div class="upload-icon">📷</div>
            <span class="upload-text">点击上传模特图片</span>
            <span class="upload-hint">支持 JPG、PNG 格式，建议小于 1MB</span>
          </div>
          <div v-if="customImage" class="image-preview">
            <img :src="customImage" alt="模特图片" class="uploaded-image" />
            <div class="image-overlay">
              <span class="change-text">点击更换图片</span>
            </div>
          </div>
          <input ref="customFileInput" type="file" id="custom-file-input" class="file-input" @change="handleFileChange" @click.stop accept="image/*" />
        </div>
      </div>

      <!-- 上传衣服图片 -->
      <div class="upload-section">
        <h3 class="section-title">
          <span class="title-icon">👕</span>
          上传服装图片
        </h3>
        <div class="upload-box" @click="handleClothingUpload" :class="{ 'has-image': clothingImage }">
          <div v-if="!clothingImage" class="upload-placeholder">
            <div class="upload-icon">🎽</div>
            <span class="upload-text">点击上传服装图片</span>
            <span class="upload-hint">支持 JPG、PNG 格式，建议小于 1MB</span>
          </div>
          <div v-if="clothingImage" class="image-preview">
            <img :src="clothingImage" alt="服装图片" class="uploaded-image" />
            <div class="image-overlay">
              <span class="change-text">点击更换图片</span>
            </div>
          </div>
          <input ref="clothingFileInput" type="file" id="clothing-file-input" class="file-input" @change="handleFileChange" @click.stop accept="image/*" />
        </div>
      </div>
    </div>

    <!-- 生成按钮 -->
    <div class="action-container">
      <button
        class="generate-button"
        @click="handleGenerate"
        :disabled="!customImage || !clothingImage"
        :class="{ 'ready': customImage && clothingImage }"
      >
        <span class="button-icon">✨</span>
        <span class="button-text">立即生成虚拟换衣</span>
      </button>
    </div>
  </div>
</template>

<script>
import { ref } from 'vue'
import { BASE_URL } from '../config'
import { ElMessage } from 'element-plus'
// import axios from 'axios'
/*虚拟换衣*/
export default {
  name: 'XuNiHuanYi',
  setup() {
    // 使用ref创建响应式变量
    const customImage = ref(null);  // 保存自定义模特图片的文件路径
    const clothingImage = ref(null);  // 保存衣服图片的文件路径
    const generatedImage = ref(null);  // 保存生成的图片路径
    const customFile = ref(null);  // 保存原始文件对象
    const clothingFile = ref(null); // 保存原始文件对象*/

    // 引用DOM元素
    const customFileInput = ref(null);
    const clothingFileInput = ref(null);
    
    // 处理上传自定义模特
    const handleCustomUpload = (event) => {
      event.stopPropagation();
      if (!customImage.value ) {
        customFileInput.value.click();
      }
    };

    // 处理选择衣服图片
    const handleClothingUpload = (event) => {
      event.stopPropagation();
      // 仅当没有选择图片时，才触发文件选择框
      if (!clothingImage.value) {
        clothingFileInput.value.click();
      }
    };

    // 处理文件选择
    const handleFileChange = (event) => {
      const file = event.target.files[0];  // 获取上传的文件
      // 超过8kB的文件不处理
      if (file && file.size > 1<<20) {
        alert('文件大小超过限制，请选择小于8kB的文件');
        return;
      }
      if (file) {
  
        const reader = new FileReader();
        reader.onload = () => {
          // 设置为图片路径，显示图片
          if (event.target.id === 'custom-file-input') {
            customImage.value = reader.result;
            customFile.value = file;  // 保存原始文件
            console.log('自定义模特文件', file.size);  // 输出文件大小
          } else if (event.target.id === 'clothing-file-input') {
            clothingImage.value = reader.result;
            clothingFile.value = file;  // 保存原始文件
            console.log('自定义模特文件', file.size);
          }
        };
        
        reader.readAsDataURL(file);  // 读取文件为 Data URL 以便显示图片
        
      }
    };

    // 立刻生成按钮的点击事件
    const handleGenerate = async () => {
      if (!customFile.value || !clothingFile.value) {
        alert('请上传所有必需的图片');
        return;
      }

      try {
        // 使用 fetch 替代 axios
        /*
        const response = await fetch(`${BASE_URL}/api/generate`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'type': 'UploadPerson',
            'cookie': localStorage.getItem('cookie')  // 如果需要，可以添加用户标识
          },
          body: JSON.stringify({
            custom_image: Array.from(new Uint8Array(customBinaryData.value)),
            clothing_image: Array.from(new Uint8Array(clothingBinaryData.value))
          })
        });
        */
        // 创建 FormData 对象
        const formData1 = new FormData();
        const formData2 = new FormData();
        console.log('自定义模特文件', customFile.value.size);
        // 添加文件到 FormData 对象
        formData1.append('custom_image', customFile.value);
        formData2.append('custom_cloth', clothingFile.value);
        //formData.append('clothing_image', clothingFile.value);
        //console.log('自定义模特文件', customFile.value.size);
        //console.log('当前cookie',document.cookie)
        // 具体发送请求
        const response1 = await fetch(BASE_URL, {
          method: 'POST',
          headers: {
            'type': 'UploadPerson',
          },
          credentials: 'include',
          body: formData1
        });
        const response2 = await fetch(BASE_URL, {
          method: 'POST',
          headers: {
            'type': 'UploadClothes',
            //'cookieid': 'test'  // 如果需要，可以添加用户标识
          },
          credentials: 'include',
          body: formData2
        });
        console.log(response1)
        console.log(response2)
        ElMessage.success('虚拟换衣正在处理中，请前往历史记录查询...');
        /*
        if (!response1.ok || !response2.ok) {
          throw new Error(`HTTP error! status: ${response1.status}`);
        }
        console.log('请求成功，正在处理响应...');
        const data = await response1.json();
        if(data.status )
        console.log('后端响应', data);
        generatedImage.value = data.generated_image;
        alert('生成成功');
        */
      } catch (error) {
        console.error('生成失败', error);
        alert('生成失败：' + error.message);
      }
    };
    
    // 返回需要在模板中使用的变量和方法
    return {
      customImage,
      clothingImage,
      generatedImage,
      customFileInput,
      clothingFileInput,
      handleCustomUpload,
      handleClothingUpload,
      handleFileChange,
      handleGenerate,
    }
  }
}
</script>

<style scoped>
.xu-ni-huan-yi {
  max-width: 1200px;
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

/* 上传容器 */
.upload-container {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 32px;
  margin-bottom: 48px;
}

.upload-section {
  background: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(20px);
  border: 1px solid rgba(102, 126, 234, 0.1);
  border-radius: 20px;
  padding: 24px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
}

.upload-section:hover {
  transform: translateY(-4px);
  box-shadow: 0 12px 40px rgba(102, 126, 234, 0.15);
}

.section-title {
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 20px;
  font-weight: 600;
  color: #333;
  margin: 0 0 20px 0;
  padding-bottom: 12px;
  border-bottom: 2px solid rgba(102, 126, 234, 0.1);
}

.title-icon {
  font-size: 24px;
  filter: grayscale(0.3);
}

/* 上传框 */
.upload-box {
  width: 100%;
  height: 280px;
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
  font-size: 48px;
  opacity: 0.6;
  margin-bottom: 8px;
}

.upload-text {
  font-size: 18px;
  font-weight: 600;
  color: #667eea;
}

.upload-hint {
  font-size: 14px;
  color: #999;
  margin-top: 4px;
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
  object-fit: cover;
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
  margin-top: 32px;
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
  min-width: 240px;
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

/* 响应式设计 */
@media (max-width: 768px) {
  .upload-container {
    grid-template-columns: 1fr;
    gap: 24px;
  }

  .page-header {
    padding: 24px;
    margin-bottom: 32px;
  }

  .page-title {
    font-size: 28px;
  }

  .upload-box {
    height: 240px;
  }

  .section-title {
    font-size: 18px;
  }

  .generate-button {
    padding: 14px 28px;
    font-size: 16px;
    min-width: 200px;
  }
}

@media (max-width: 480px) {
  .xu-ni-huan-yi {
    padding: 0 16px;
  }

  .page-header {
    padding: 20px;
  }

  .page-title {
    font-size: 24px;
  }

  .upload-section {
    padding: 20px;
  }

  .upload-box {
    height: 200px;
  }

  .upload-text {
    font-size: 16px;
  }

  .upload-hint {
    font-size: 12px;
  }
}
</style>
