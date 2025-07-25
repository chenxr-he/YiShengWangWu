<template>
      <!-- 图片查看器组件 -->
  <Teleport to="body">
  <image-viewer
    :visible="imageViewerVisible"
    :image-src="viewerImageSrc"
    :title="viewerImageTitle"
    @close="closeImageViewer"
  />
  </Teleport>
  <div class="history-container">
    <!-- 页面标题 -->
    <div class="page-header">
      <h2 class="page-title">历史记录</h2>
      <p class="page-description">查看您的所有 AI 创作历史，重温精彩作品</p>
    </div>
    <div v-for="(item,index) in history" :key="'key-'+index">
    <!-- 虚拟换衣历史记录 -->
    <div v-if="item.type=='XNCY'" class="history-section">
      <div class="section-header">
        <h3 class="section-title">
          <span class="title-icon">👔</span>
          虚拟换衣
        </h3>
      </div>
      <div class="history-items">
        <div  class="history-item">
          <div class="item-header">
            <span class="item-index">#{{ index + 1 }}</span>
            <span class="item-type">虚拟换衣</span>
          </div>
          <div class="item-content">
            <div class="image-box">
              <h4>模特图</h4>
              <div class="image-wrapper">
                <lazy-image :src="item.person" alt="模特图" @click="showImage(item.person, '模特图')"/>
              </div>
            </div>
            <div class="image-box">
              <h4>服装图</h4>
              <div class="image-wrapper">
                <lazy-image :src="item.clothes" alt="服装图" @click="showImage(item.clothes, '服装图')"/>
              </div>
            </div>
            <div class="image-box result-box">
              <h4>换衣结果</h4>
              <div class="image-wrapper">
                <lazy-image v-if="item.status" :src="item.generate" alt="换衣结果" @click="showImage(item.generate, '换衣结果')" />
                <div v-else class="no-result">
                  <span class="no-result-icon">⏳</span>
                  <span>处理中...</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 文生图历史记录 -->
    <div v-if="item.type=='WST'" class="history-section">
      <div class="section-header">
        <h3 class="section-title">
          <span class="title-icon">🖼️</span>
          文生图
        </h3>
      </div>
      <div class="history-items">
        <div  class="history-item text-to-image">
          <div class="item-header">
            <span class="item-index">#{{ index + 1 }}</span>
            <span class="item-type">文生图</span>
          </div>
          <div class="item-content">
            <div class="text-description">
              <h4>文字描述</h4>
              <div class="description-wrapper">
                <div v-if="item.descriptionText" class="description-content">
                  {{ item.descriptionText }}
                </div>
                <div v-else-if="item.descriptionUrl" class="description-loading">
                  <span class="loading-icon">⏳</span>
                  加载描述中...
                </div>
                <div v-else class="no-description">
                  <span class="no-desc-icon">📝</span>
                  暂无描述
                </div>
              </div>
            </div>
            <div class="image-box result-box">
              <h4>生成结果</h4>
              <div class="image-wrapper">
                <lazy-image v-if="item.status" :src="item.generate" alt="生成结果" @click="showImage(item.generate, '文生图结果')"/>
                <div v-else class="no-result">
                  <span class="no-result-icon">⏳</span>
                  <span>生成中...</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 人脸风格化历史记录 -->
    <div v-if="item.type=='RLFGH'" class="history-section">
      <div class="section-header">
        <h3 class="section-title">
          <span class="title-icon">🎨</span>
          人脸风格化
        </h3>
      </div>
      <div class="history-items">
        <div  class="history-item">
          <div class="item-header">
            <span class="item-index">#{{ index + 1 }}</span>
            <span class="item-type">人脸风格化</span>
          </div>
          <div class="item-content">
            <div class="image-box">
              <h4>原始人脸</h4>
              <div class="image-wrapper">
                <lazy-image :src="item.face" alt="原始人脸" @click="showImage(item.face, '原始人脸')"/>
              </div>
            </div>
            <div class="text-description">
              <h4>风格描述</h4>
              <div class="description-wrapper">
                <div v-if="item.descriptionText" class="description-content">
                  {{ item.descriptionText }}
                </div>
                <div v-else-if="item.descriptionUrl" class="description-loading">
                  <span class="loading-icon">⏳</span>
                  加载描述中...
                </div>
                <div v-else class="no-description">
                  <span class="no-desc-icon">🎭</span>
                  暂无描述
                </div>
              </div>
            </div>
            <div class="image-box result-box">
              <h4>风格化结果</h4>
              <div class="image-wrapper">
                <lazy-image v-if="item.status" :src="item.generate" alt="风格化结果" @click="showImage(item.generate, '风格化结果')"/>
                <div v-else class="no-result">
                  <span class="no-result-icon">⏳</span>
                  <span>处理中...</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 人脸肖像历史记录 -->
    <div v-if="item.type=='Portrait'" class="history-section">
      <div class="section-header">
        <h3 class="section-title">
          <span class="title-icon">👤</span>
          人脸肖像
        </h3>
      </div>
      <div class="history-items">
        <div class="history-item portrait">
          <div class="item-header">
            <span class="item-index">#{{ index + 1 }}</span>
            <span class="item-type">人脸肖像</span>
          </div>
          <div class="item-content">
            <div class="image-box">
              <h4>原始人脸</h4>
              <div class="image-wrapper">
                <lazy-image :src="item.person" alt="原始人脸" @click="showImage(item.person, '原始人脸')"/>
              </div>
            </div>
            <div class="image-box result-box">
              <h4>肖像作品</h4>
              <div class="image-wrapper">
                <lazy-image v-if="item.status" :src="item.generate" alt="肖像作品" @click="showImage(item.generate, '肖像作品')"/>
                <div v-else class="no-result">
                  <span class="no-result-icon">⏳</span>
                  <span>创作中...</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 智能抠图历史记录 -->
    <div v-if="item.type=='KouTu'" class="history-section">
      <div class="section-header">
        <h3 class="section-title">
          <span class="title-icon">✂️</span>
          智能抠图
        </h3>
      </div>
      <div class="history-items">
        <div  class="history-item koutu">
          <div class="item-header">
            <span class="item-index">#{{ index + 1 }}</span>
            <span class="item-type">智能抠图</span>
          </div>
          <div class="item-content">
            <div class="image-box">
              <h4>原始图片</h4>
              <div class="image-wrapper">
                <lazy-image :src="item.image" alt="原始图片" @click="showImage(item.image, '原始图片')"/>
              </div>
            </div>
            <div class="image-box result-box">
              <h4>抠图结果</h4>
              <div class="image-wrapper transparent-bg">
                <lazy-image v-if="item.status" :src="item.generate" alt="抠图结果" @click="showImage(item.generate, '抠图结果')"/>
                <div v-else class="no-result">
                  <span class="no-result-icon">⏳</span>
                  <span>抠图中...</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    </div>
    <!-- 加载状态 -->
    <div v-if="loadingStatus" class="loading-container">
      <div class="loading-animation">
        <div class="loading-dots">
          <span></span>
          <span></span>
          <span></span>
        </div>
        <p class="loading-text" :class="{ 'success': isSuccess, 'error': !isSuccess }">
          {{ loadingMessage }}
        </p>
      </div>
    </div>

    <!-- 无历史记录时显示 -->
    <div v-if="!hasAnyHistory && !loadingStatus" class="no-history">
      <div class="empty-icon">📋</div>
      <p class="empty-text">暂无历史记录</p>
      <p class="empty-hint">开始使用 AI 功能，创作您的第一个作品吧！</p>
    </div>

    <!-- 底部加载按钮 -->
    <div class="load-button-container">
      <button @click="loadHistoryData" :disabled="isLoading" class="load-button">
        <span class="button-icon">
          <span v-if="isLoading" class="loading-spinner">⏳</span>
          <span v-else>🔄</span>
        </span>
        <span class="button-text">
          {{ isLoading ? '加载中...' : '刷新历史记录' }}
        </span>
      </button>
    </div>
  </div>
</template>

<script>
import { ref, reactive, computed, onMounted, watch, onUnmounted, nextTick  } from 'vue'
import { BASE_URL } from '../config'
import LazyImage from './LazyImage.vue' // 导入懒加载图片组件
import ImageViewer from './ImageViewer.vue' // 导入图片查看器组件

export default {
  name: 'LiShiJiLu',
  components: {
    LazyImage, 
    ImageViewer 
  },
  setup() {
    const history = reactive([])
    
    const isLoading = ref(false)
    const loadingStatus = ref(false)
    const loadingMessage = ref('')
    const isSuccess = ref(false)

    // 图片查看器相关状态
    const imageViewerVisible = ref(false)
    const viewerImageSrc = ref('')
    const viewerImageTitle = ref('')

    // 显示图片查看器
    const showImage = (src, title) => {
      viewerImageSrc.value = src
      viewerImageTitle.value = title
      imageViewerVisible.value = true
    }

    // 关闭图片查看器
    const closeImageViewer = () => {
      imageViewerVisible.value = false
    }

    // 是否有任何历史记录
    const hasAnyHistory = computed(() => {
      return history.length>0
    })

    // 显示状态消息，几秒后自动消失
    const showStatusMessage = (message, success) => {
      loadingStatus.value = true
      loadingMessage.value = message
      isSuccess.value = success

      setTimeout(() => {
        loadingStatus.value = false
      }, 3000)
    }
    
    // 加载历史记录
    const loadHistoryData = async () => {
      try {

        isLoading.value = true
        const response = await fetch(BASE_URL, {
          method: 'GET',
          headers: {
            'type': 'HistoryInfo',
          },
          credentials: 'include',
        });

        const resp = await response.json();
        console.log(resp)
        // 清空之前的数据
        history.splice(0,history.length)
        Object.keys(history).forEach(key => {
          history[key] = []
        })
        for(const key in resp){
            console.log(2)
            const record=resp[key]
            const keySplits = key.split('_');
            let keyPrefix;
            
            if(keySplits.length <= 2) {
                keyPrefix = keySplits[0];
            } else {                
                const lastPart = keySplits[keySplits.length - 1];               
                if(!isNaN(Number(lastPart))) {                   
                    keyPrefix = keySplits.slice(0, -1).join('_');
                } else {                  
                    keyPrefix = key;
                }
            } 
            //
            const date=new Date(record["date"])
            //
            if(keyPrefix=="XNCY"){
                const person=BASE_URL+record["person"]
                const clothes=BASE_URL+record["clothes"]
                const status=record["status"]
                const generate=BASE_URL+record["generate"]
                const playid =BASE_URL+record["playid"]
                console.log(person,clothes,status,generate,playid)
                history.push({"type":"XNCY","person":person,"clothes":clothes,"generate":generate,"status":status,"date":date})
            }
            else if(keyPrefix=="WST"){
                const descriptionUrl=BASE_URL+record["description"]
                const status=record["status"]
                const generate=BASE_URL+record["generate"]
                const playid =BASE_URL+record["playid"]                            
                const historyItem = {
                    "type":"WST",
                    "date":date,
                    "descriptionUrl": descriptionUrl,
                    "descriptionText": "", 
                    "generate": generate,
                    "status": status
                }                            
                history.push(historyItem)
                
                // 异步获取描述文本内容
                fetch(descriptionUrl)
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('无法获取描述文本');
                        }
                        return response.text();
                    })
                    .then(text => {
                        // 更新历史记录中的描述文本
                        historyItem.descriptionText = text;
                    })
                    .catch(error => {
                        console.error('获取描述文本失败:', error);
                        historyItem.descriptionText = '无法加载描述';
                    });
                console.log(descriptionUrl,status,generate,playid)
            }
            else if(keyPrefix=="RLFGH"){
                const face=BASE_URL+record["face"]
                const descriptionUrl=BASE_URL+record["description"]
                const status=record["status"]
                const generate=BASE_URL+record["generate"]
                const playid =BASE_URL+record["playid"]
                const historyItem = {
                  "date":date,
                  "type":"RLFGH",
                    "face": face,
                    "descriptionUrl": descriptionUrl,
                    "descriptionText": "", 
                    "generate": generate,
                    "status": status
                }                               
                history.push(historyItem)
                
                // 异步获取描述文本内容
                fetch(descriptionUrl)
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('无法获取描述文本');
                        }
                        return response.text();
                    })
                    .then(text => {
                        // 更新历史记录中的描述文本
                        historyItem.descriptionText = text;
                    })
                    .catch(error => {
                        console.error('获取描述文本失败:', error);
                        historyItem.descriptionText = '无法加载描述';
                    });
                console.log(descriptionUrl,status,generate,playid)
            }
            else if(keyPrefix=="Portrait"){
                const person=BASE_URL+record["person"]
                const status=record["status"]
                const generate=BASE_URL+record["generate"]
                const playid =BASE_URL+record["playid"]
                console.log(person,status,generate,playid)
                history.push({"date":date,"type":"Portrait","person":person,"generate":generate,"status":status})
            } 
            else if(keyPrefix=="KouTu"){
                const image=BASE_URL+record["image"]
                const status=record["status"]
                const generate=BASE_URL+record["generate"]
                const playid =BASE_URL+record["playid"]
                console.log(image,status,generate,playid)
                history.push({"date":date,"type":"KouTu","image":image,"generate":generate,"status":status})
            }
        }
        console.log(history)
        history.sort((a,b)=>b.date-a.date)
        showStatusMessage('历史记录加载成功！', true)
      } catch (error) {
        console.error('加载历史记录失败：', error)
        showStatusMessage('历史记录加载失败，请稍后重试！', false)
      } finally {
        isLoading.value = false
      }
    }

    // 检查文本是否溢出
    const checkTextOverflow = () => {
      nextTick(() => {
        const descriptions = document.querySelectorAll('.description-content');
        descriptions.forEach(el => {
          if (el.scrollHeight > el.clientHeight) {
            el.classList.add('overflow');
          } else {
            el.classList.remove('overflow');
          }
        });
      });
    }
    
    // 在组件挂载时检查
    onMounted(() => {
      loadHistoryData();
      window.addEventListener('resize', checkTextOverflow);
    })
    
    // 在数据更新后检查
    watch(() => history, () => {
      checkTextOverflow();
    }, { deep: true });
    
    // 组件卸载前移除事件监听器
    onUnmounted(() => {
      window.removeEventListener('resize', checkTextOverflow);
    });
    
    return {
      history,
      isLoading,
      loadingStatus,
      loadingMessage,
      isSuccess,
      hasAnyHistory,
      imageViewerVisible,
      viewerImageSrc,
      viewerImageTitle,
      loadHistoryData,
      showImage,
      closeImageViewer,
      checkTextOverflow
    };
  }
}
</script>

<style scoped>
.history-container {
  max-width: 1400px;
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

/* 历史记录区域 */
.history-section {
  margin-bottom: 48px;
  background: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(20px);
  border: 1px solid rgba(102, 126, 234, 0.1);
  border-radius: 20px;
  padding: 32px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
}

.history-section:hover {
  transform: translateY(-2px);
  box-shadow: 0 12px 40px rgba(102, 126, 234, 0.15);
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
  padding-bottom: 16px;
  border-bottom: 2px solid rgba(102, 126, 234, 0.1);
}

.section-title {
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 24px;
  font-weight: 600;
  color: #333;
  margin: 0;
}

.title-icon {
  font-size: 28px;
  filter: grayscale(0.2);
}

.item-count {
  font-size: 14px;
  color: #667eea;
  background: rgba(102, 126, 234, 0.1);
  padding: 6px 12px;
  border-radius: 20px;
  font-weight: 500;
}

.history-items {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.history-item {
  background: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(102, 126, 234, 0.1);
  border-radius: 16px;
  padding: 24px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;
}

.history-item::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 3px;
  background: linear-gradient(90deg, #667eea, #764ba2);
  border-radius: 16px 16px 0 0;
}

.history-item:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 30px rgba(102, 126, 234, 0.15);
}

.item-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}

.item-index {
  font-size: 14px;
  font-weight: 600;
  color: #667eea;
  background: rgba(102, 126, 234, 0.1);
  padding: 4px 12px;
  border-radius: 12px;
}

.item-type {
  font-size: 12px;
  color: #999;
  background: rgba(0, 0, 0, 0.05);
  padding: 4px 8px;
  border-radius: 8px;
}

.item-content {
  display: grid;
  gap: 20px;
  align-items: start;
}

/* 默认三列布局 */
.history-item .item-content {
  grid-template-columns: 1fr 1fr 1fr;
}

/* 文生图两列布局 */
.text-to-image .item-content {
  grid-template-columns: 1fr 1fr;
}

/* 新增：人脸肖像和智能抠图的两列布局 */
.history-item.portrait .item-content,
.history-item.koutu .item-content {
  grid-template-columns: 1fr 1fr; /* 1:1比例 */
}

.image-box {
  background: rgba(255, 255, 255, 0.9);
  border: 1px solid rgba(102, 126, 234, 0.1);
  border-radius: 12px;
  padding: 16px;
  text-align: center;
  transition: all 0.3s ease;
}

.image-box:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 15px rgba(102, 126, 234, 0.2);
}

.image-box h4 {
  font-size: 14px;
  font-weight: 600;
  color: #333;
  margin: 0 0 12px 0;
  padding: 6px 12px;
  background: rgba(102, 126, 234, 0.1);
  border-radius: 16px;
  display: inline-block;
}

.image-wrapper {
  border-radius: 8px;
  overflow: hidden;
  background: #f8f9fa;
  min-height: 250px; /* 设置固定最小高度 */
  height: 250px; /* 设置固定高度 */
  min-height: 150px;
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative; /* 为悬停效果添加相对定位 */
}

.image-box img {
  width: 100%;
  max-width: 200px;
  width: auto; /* 改为自动宽度 */
  height: auto;
  max-height: 200px;
  object-fit: contain;
  border-radius: 8px;
  transition: transform 0.3s ease;
}

.image-box img:hover {
  transform: scale(1.05);
}

/* 透明背景展示（抠图结果） */
.transparent-bg {
  background:
    linear-gradient(45deg, #f0f0f0 25%, transparent 25%),
    linear-gradient(-45deg, #f0f0f0 25%, transparent 25%),
    linear-gradient(45deg, transparent 75%, #f0f0f0 75%),
    linear-gradient(-45deg, transparent 75%, #f0f0f0 75%);
  background-size: 16px 16px;
  background-position: 0 0, 0 8px, 8px -8px, -8px 0px;
}

/* 修改文字描述区域样式，与首页保持一致 */
.text-description {
  background: rgba(255, 255, 255, 0.9);
  border: 1px solid rgba(102, 126, 234, 0.1);
  border-radius: 12px;
  padding: 16px;
  display: flex;
  flex-direction: column;
  transition: all 0.3s ease;
  height: 100%; /* 确保整个容器高度一致 */
}

.text-description:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 15px rgba(102, 126, 234, 0.2);
}

.text-description h4 {
  font-size: 14px;
  font-weight: 600;
  color: #333;
  margin: 0 0 12px 0;
  padding: 6px 12px;
  background: rgba(102, 126, 234, 0.1);
  border-radius: 16px;
  display: inline-block;
  align-self: center; /* 居中标题 */
}

.description-wrapper {
  flex-grow: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 180px; /* 设置最小高度，与图片容器相似 */
  width: 100%;
  overflow: hidden; /* 避免内容溢出 */
}

/* 文字内容样式优化，与首页一致 */
.description-content {
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.05), rgba(118, 75, 162, 0.05));
  padding: 20px;
  border-radius: 8px;
  color: #333;
  line-height: 1.6;
  font-size: 20px; /* 增大字体 */
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center; /* 文字居中 */
  font-weight: 500;
  word-break: break-word;
  font-style: italic;
  box-shadow: inset 0 0 10px rgba(0, 0, 0, 0.03);
  overflow-y: auto;
}

/* 加载中和无描述状态的样式 */
.description-loading, .no-description {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding: 20px;
  border-radius: 8px;
  font-size: 16px;
  width: 100%;
  height: 100%;
  min-height: 180px;
}

/* 渐变淡出效果，用于长文本 */
.description-content:after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 30px;
  background: linear-gradient(to top, rgba(248, 250, 252, 0.9), transparent);
  pointer-events: none;
  opacity: 0;
  transition: opacity 0.3s;
}

/* 当内容溢出时显示渐变效果 */
.description-content.overflow:after {
  opacity: 1;
}

.description-loading {
  background: rgba(255, 193, 7, 0.1);
  color: #856404;
}

.no-description {
  background: rgba(108, 117, 125, 0.1);
  color: #6c757d;
}

.loading-icon, .no-desc-icon {
  font-size: 24px;
  opacity: 0.6;
}

.no-result {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 8px;
  min-height: 150px;
  background: linear-gradient(135deg, rgba(108, 117, 125, 0.05), rgba(108, 117, 125, 0.1));
  color: #6c757d;
  font-size: 14px;
  border-radius: 8px;
}

.no-result-icon {
  font-size: 32px;
  opacity: 0.6;
  animation: spin 2s linear infinite;
}

@keyframes spin {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}

/* 加载状态 */
.loading-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 200px;
  background: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(20px);
  border: 1px solid rgba(102, 126, 234, 0.1);
  border-radius: 20px;
  margin-bottom: 32px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
}

.loading-animation {
  text-align: center;
}

.loading-dots {
  display: flex;
  justify-content: center;
  gap: 8px;
  margin-bottom: 16px;
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
  font-size: 16px;
  font-weight: 600;
  margin: 0;
}

.loading-text.success {
  color: #28a745;
}

.loading-text.error {
  color: #dc3545;
}

/* 空状态 */
.no-history {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 300px;
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.05), rgba(118, 75, 162, 0.05));
  border: 2px dashed rgba(102, 126, 234, 0.3);
  border-radius: 20px;
  margin-bottom: 32px;
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
  font-size: 20px;
  font-weight: 600;
  color: #667eea;
  margin: 0 0 8px 0;
}

.empty-hint {
  font-size: 14px;
  color: #999;
  margin: 0;
}

/* 加载按钮 */
.load-button-container {
  text-align: center;
  margin-top: 32px;
}

.load-button {
  display: inline-flex;
  align-items: center;
  gap: 12px;
  padding: 16px 32px;
  background: linear-gradient(135deg, #667eea, #764ba2);
  color: white;
  border: none;
  border-radius: 25px;
  cursor: pointer;
  font-size: 16px;
  font-weight: 600;
  transition: all 0.3s ease;
  box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
  position: relative;
  overflow: hidden;
}

.load-button::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
  transition: left 0.5s ease;
}

.load-button:hover:not(:disabled)::before {
  left: 100%;
}

.load-button:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(102, 126, 234, 0.5);
}

.load-button:disabled {
  background: linear-gradient(135deg, #6c757d, #495057);
  cursor: not-allowed;
  transform: none;
}

.button-icon {
  font-size: 18px;
}

.loading-spinner {
  animation: spin 1s linear infinite;
}

.button-text {
  font-size: 16px;
}

/* 响应式设计 */
@media (max-width: 1024px) {
  .history-item .item-content {
    grid-template-columns: 1fr 1fr;
    gap: 16px;
  }

  .text-to-image .item-content {
    grid-template-columns: 1fr 1.2fr;
  }
}

@media (max-width: 768px) {
  .history-container {
    padding: 0 16px;
  }

  .page-header {
    padding: 24px;
    margin-bottom: 32px;
  }

  .page-title {
    font-size: 28px;
  }

  .history-section {
    padding: 24px;
    margin-bottom: 32px;
  }

  .section-header {
    flex-direction: column;
    gap: 12px;
    align-items: flex-start;
  }

  .section-title {
    font-size: 22px;
  }

  .history-item {
    padding: 20px;
  }

  .history-item .item-content {
    grid-template-columns: 1fr;
    gap: 16px;
  }

  .image-box img {
    max-width: 150px;
    max-height: 150px;
  }

  .load-button {
    padding: 14px 28px;
    font-size: 15px;
  }
}

@media (max-width: 480px) {
  .page-header {
    padding: 20px;
  }

  .page-title {
    font-size: 24px;
  }

  .history-section {
    padding: 20px;
  }

  .section-title {
    font-size: 20px;
  }

  .history-item {
    padding: 16px;
  }

  .image-box {
    padding: 12px;
  }

  .text-description {
    padding: 12px;
  }

  .empty-icon {
    font-size: 48px;
  }

  .empty-text {
    font-size: 18px;
  }
}

/* 为图片添加可点击效果 */
.image-wrapper {
  /* ...现有样式 */
  cursor: pointer;
  transition: all 0.3s ease;
}

.image-wrapper:hover {
  box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.5);
}

.image-wrapper::after {
  content: '🔍';
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background: rgba(0, 0, 0, 0.6);
  color: white;
  padding: 8px;
  border-radius: 50%;
  font-size: 18px;
  opacity: 0;
  transition: opacity 0.3s ease;
}

.image-wrapper:hover::after {
  opacity: 1;
}

/* 当图片正在加载或没有结果时，禁用点击和悬停效果 */
.no-result + .image-wrapper,
.description-loading + .image-wrapper,
.no-description + .image-wrapper {
  cursor: default;
}

.no-result + .image-wrapper:hover::after,
.description-loading + .image-wrapper:hover::after,
.no-description + .image-wrapper:hover::after {
  display: none;
}
</style>