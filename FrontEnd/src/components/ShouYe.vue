<template>
  <div class="shouye-container">
    <!-- 状态提示 -->
    <div v-if="loadingStatus" class="status-message" :class="{ 'success': isSuccess, 'error': !isSuccess }">
      {{ loadingMessage }}
    </div>
    
    <!-- 功能选择按钮 -->
    <div class="function-buttons">
      <button 
        v-for="(btn, index) in functionButtons" 
        :key="index" 
        :class="{ 'active': activeFunction === btn.value }"
        @click="switchFunction(btn.value)">
        {{ btn.label }}
      </button>
    </div>

    <!-- 刷新按钮 -->
    <div class="refresh-button-container">
      <button @click="loadHistoryData" :disabled="isLoading" class="refresh-button">
        <span v-if="isLoading">加载中...</span>
        <span v-else>刷新数据</span>
      </button>
    </div>

    <div v-if="activeFunction === 'SUOYOU'" class="content-section">
    <h2 class="section-title">所有</h2>
    
    <!-- 虚拟穿衣 -->
    <div v-if="history.XNCY && history.XNCY.length > 0" class="category-section">
        <h3 class="category-title">虚拟穿衣</h3>
        <div class="image-grid">
        <div v-for="(item, index) in history.XNCY" :key="'all-xncy-' + index" class="grid-item">
            <div class="image-card" @click="switchAndScroll('XNCY')">
            <lazy-image v-if="item.status" :src="item.generate" alt="虚拟穿衣结果" />
            <div v-else class="no-result">暂无结果</div>
            </div>
        </div>
        </div>
    </div>
    
    <!-- 文生图 -->
    <div v-if="history.WST && history.WST.length > 0" class="category-section">
        <h3 class="category-title">文生图</h3>
        <div class="image-grid">
        <div v-for="(item, index) in history.WST" :key="'all-wst-' + index" class="grid-item">
            <div class="image-card" @click="switchAndScroll('WST')">
            <lazy-image v-if="item.status" :src="item.generate" alt="文生图结果" />
            <div v-else class="no-result">暂无结果</div>
            </div>
        </div>
        </div>
    </div>
    
    <!-- 人脸风格化 -->
    <div v-if="history.RLFGH && history.RLFGH.length > 0" class="category-section">
        <h3 class="category-title">人脸风格化</h3>
        <div class="image-grid">
        <div v-for="(item, index) in history.RLFGH" :key="'all-rlfgh-' + index" class="grid-item">
            <div class="image-card" @click="switchAndScroll('RLFGH')">
            <lazy-image v-if="item.status" :src="item.generate" alt="人脸风格化结果" />
            <div v-else class="no-result">暂无结果</div>
            </div>
        </div>
        </div>
    </div>
    
    <!-- 人脸肖像 -->
    <div v-if="history.Portrait && history.Portrait.length > 0" class="category-section">
        <h3 class="category-title">人脸肖像</h3>
        <div class="image-grid">
        <div v-for="(item, index) in history.Portrait" :key="'all-portrait-' + index" class="grid-item">
            <div class="image-card" @click="switchAndScroll('Portrait')">
            <lazy-image v-if="item.status" :src="item.generate" alt="人脸肖像结果" />
            <div v-else class="no-result">暂无结果</div>
            </div>
        </div>
        </div>
    </div>
    
    <!-- 智能抠图 -->
    <div v-if="history.kouTu && history.kouTu.length > 0" class="category-section">
        <h3 class="category-title">智能抠图</h3>
        <div class="image-grid">
        <div v-for="(item, index) in history.kouTu" :key="'all-koutu-' + index" class="grid-item">
            <div class="image-card" @click="switchAndScroll('kouTu')">
            <lazy-image v-if="item.status" :src="item.generate" alt="智能抠图结果" />
            <div v-else class="no-result">暂无结果</div>
            </div>
        </div>
        </div>
    </div>
    
    <!-- 无数据显示 -->
    <div v-if="!hasAnyData" class="no-data">暂无任何数据</div>
    </div>

    <!-- 虚拟穿衣展示区域 -->
    <div v-if="activeFunction === 'XNCY'" class="content-section">
      <h2 class="section-title">虚拟穿衣</h2>
      <div class="image-grid">
        <div v-for="(item, index) in history.XNCY" :key="'xncy-' + index" class="grid-item">
          <div class="image-card" @click="switchAndScroll('XNCY')">
            <lazy-image v-if="item.status" :src="item.generate" alt="虚拟穿衣结果" />
            <div v-else class="no-result">暂无结果</div>
          </div>
        </div>
        <div v-if="history.XNCY.length === 0" class="no-data">暂无数据</div>
      </div>
    </div>

    <!-- 文生图展示区域 -->
    <div v-if="activeFunction === 'WST'" class="content-section">
      <h2 class="section-title">文生图</h2>
      <div class="image-grid">
        <div v-for="(item, index) in history.WST" :key="'wst-' + index" class="grid-item">
          <div class="image-card" @click="switchAndScroll('WST')">
            <h4>结果图</h4>
            <lazy-image v-if="item.status" :src="item.generate" alt="文生图结果" />
            <div v-else class="no-result">暂无结果</div>
          </div>
        </div>
        <div v-if="history.WST.length === 0" class="no-data">暂无数据</div>
      </div>
    </div>

    <!-- 人脸风格化展示区域 -->
    <div v-if="activeFunction === 'RLFGH'" class="content-section">
      <h2 class="section-title">人脸风格化</h2>
      <div class="image-grid">
        <div v-for="(item, index) in history.RLFGH" :key="'rlfgh-' + index" class="grid-item">
          <div class="image-card" @click="switchAndScroll('RLFGH')">
            <lazy-image v-if="item.status" :src="item.generate" alt="人脸风格化结果" />
            <div v-else class="no-result">暂无结果</div>
          </div>
        </div>
        <div v-if="history.RLFGH.length === 0" class="no-data">暂无数据</div>
      </div>
    </div>

    <!-- 人脸肖像展示区域 -->
    <div v-if="activeFunction === 'Portrait'" class="content-section">
      <h2 class="section-title">人脸肖像</h2>
      <div class="image-grid">
        <div v-for="(item, index) in history.Portrait" :key="'portrait-' + index" class="grid-item">
          <div class="image-card" @click="switchAndScroll('Portrait')">
            <lazy-image v-if="item.status" :src="item.generate" alt="人脸肖像结果" />
            <div v-else class="no-result">暂无结果</div>
          </div>
        </div>
        <div v-if="history.Portrait.length === 0" class="no-data">暂无数据</div>
      </div>
    </div>

    <!-- 智能抠图展示区域 -->
    <div v-if="activeFunction === 'KouTu'" class="content-section">
      <h2 class="section-title">智能抠图</h2>
      <div class="image-grid">
        <div v-for="(item, index) in history.kouTu" :key="'koutu-' + index" class="grid-item">
          <div class="image-card" @click="switchAndScroll('kouTu')">
            <lazy-image v-if="item.status" :src="item.generate" alt="智能抠图结果" />
            <div v-else class="no-result">暂无结果</div>
          </div>
        </div>
        <div v-if="history.kouTu.length === 0" class="no-data">暂无数据</div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, reactive, onMounted,computed } from 'vue'
import { BASE_URL } from '../config'
import { useRouter } from 'vue-router'
import LazyImage from './LazyImage.vue' // 导入懒加载图片组件

export default {
  name: 'ShouYe',
  components: {
    LazyImage 
  },
  setup() {
    const router = useRouter() 
    const activeFunction = ref('SUOYOU') 
    
    // 功能按钮配置
    const functionButtons = [
      { label: '全部', value: 'SUOYOU' },
      { label: '虚拟穿衣', value: 'XNCY' },
      { label: '文生图', value: 'WST' },
      { label: '人脸风格化', value: 'RLFGH' },
      { label: '人脸肖像', value: 'Portrait' },
      { label: '智能抠图', value: 'KouTu' }
    ]
    
    // 历史数据
    const history = reactive({
      XNCY: [],
      WST: [],
      RLFGH: [],
      Portrait: [],
      kouTu: []
    })

    const hasAnyData = computed(() => {
        return history.XNCY.length > 0 || 
                history.WST.length > 0 || 
                history.RLFGH.length > 0 || 
                history.Portrait.length > 0 || 
                history.kouTu.length > 0;
    })
    
    const switchAndScroll = (functionName) => {
      // 根据功能名称映射到对应的路由路径 - 这里不包含 /edit/ 前缀
      const routePaths = {
        'XNCY': 'xu-ni-huan-yi',
        'WST': 'wen-sheng-tu',
        'RLFGH': 'ren-lian-feng-ge-hua',
        'Portrait': 'ren-lian-xiao-xiang',
        'kouTu': 'zhi-neng-kou-tu'
      }
      
      const routeName = routePaths[functionName];
      console.log("当前功能:", functionName, "对应路由名称:", routeName);
      
      if (routeName) {
        // 构建完整路径
        const fullPath = `/edit/${routeName}`;
        
        // 这种方式与EditView.vue的逻辑兼容
        // 1. 使用replace而不是push，避免创建过多历史记录
        // 2. 设置query参数，确保即使路径相同，也会触发路由变化
        router.replace({
          path: fullPath,
          query: { t: Date.now() } // 添加时间戳确保每次导航都是唯一的
        });
        
        console.log("跳转到:", fullPath);
        
        // 滚动到页面顶部
        window.scrollTo({
          top: 0,
          behavior: 'smooth'
        });
      } else {
        // 处理本地切换逻辑
        activeFunction.value = functionName;
        window.scrollTo({
          top: 0,
          behavior: 'smooth'
        });
      }
    }

    const isLoading = ref(false)
    const loadingStatus = ref(false)
    const loadingMessage = ref('')
    const isSuccess = ref(false)

    // 切换功能
    const switchFunction = (functionName) => {
      activeFunction.value = functionName
    }

    // 显示状态消息
    const showStatusMessage = (message, success) => {
      loadingStatus.value = true
      loadingMessage.value = message
      isSuccess.value = success

      setTimeout(() => {
        loadingStatus.value = false
      }, 3000)
    }

    // 刷新加载历史记录数据
    const loadHistoryData = async () => {
      try {
        isLoading.value = true
        
        const response = await fetch(BASE_URL, {
          method: 'GET',
          headers: {
            'type': 'Home',
            'type2': '0' // 所有
          },
          credentials: 'include',
        });

        const resp = await response.json();
        console.log("后端返回的数据：", resp);
        Object.keys(history).forEach(key => {
          history[key] = []
        })
        for(const key in resp){
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
            
            if(keyPrefix=="XNCY"){
                const person=BASE_URL+record["person"]
                const clothes=BASE_URL+record["clothes"]
                const status=record["status"]
                const generate=BASE_URL+record["generate"]
                const playid =BASE_URL+record["playid"]
                console.log(person,clothes,status,generate,playid)
                history.XNCY.push({"person":person,"clothes":clothes,"generate":generate,"status":status})
            }
            else if(keyPrefix=="WST"){
                const descriptionUrl=BASE_URL+record["description"]
                const status=record["status"]
                const generate=BASE_URL+record["generate"]
                const playid =BASE_URL+record["playid"]
                const historyItem = {
                    "descriptionUrl": descriptionUrl,
                    "descriptionText": "", 
                    "generate": generate,
                    "status": status
                }
                history.WST.push(historyItem)
                
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
                    "face": face,
                    "descriptionUrl": descriptionUrl,
                    "descriptionText": "", 
                    "generate": generate,
                    "status": status
                }
                history.RLFGH.push(historyItem)
                
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
                history.Portrait.push({"person":person,"generate":generate,"status":status})
            } 
            else if(keyPrefix=="KouTu"){
                const image=BASE_URL+record["image"]
                const status=record["status"]
                const generate=BASE_URL+record["generate"]
                const playid =BASE_URL+record["playid"]
                console.log(image,status,generate,playid)
                history.kouTu.push({"image":image,"generate":generate,"status":status})
            }
        }
        
        showStatusMessage('数据加载成功！', true)
      } catch (error) {
        console.error('加载数据失败：', error)
        showStatusMessage('数据加载失败，请稍后重试！', false)
      } finally {
        isLoading.value = false
      }
    }
    
    onMounted(() => {
      loadHistoryData()
    })
    
    return {
      activeFunction,
      functionButtons, 
      history,
      isLoading,
      loadingStatus,
      loadingMessage,
      isSuccess,
      hasAnyData,
      loadHistoryData,
      switchFunction,
      switchAndScroll
    };
  }
}
</script>

<style scoped>
.shouye-container {
  max-width: 1400px;
  margin: 0 auto;
  position: relative;
}

.shouye-container > * {
  position: relative;
  z-index: 1;
}

.function-buttons {
  display: flex;
  justify-content: center;
  flex-wrap: wrap;
  gap: 12px;
  margin-bottom: 20px;
  background: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(20px);
  border: 1px solid rgba(102, 126, 234, 0.1);
  border-radius: 20px;
  padding: 20px;
  box-shadow:
    0 8px 32px rgba(0, 0, 0, 0.1),
    0 2px 8px rgba(102, 126, 234, 0.1);
}

.function-buttons button {
  padding: 12px 24px;
  border: none;
  background: rgba(255, 255, 255, 0.8);
  border: 2px solid rgba(102, 126, 234, 0.2);
  border-radius: 25px;
  cursor: pointer;
  font-weight: 600;
  font-size: 14px;
  color: #667eea;
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;
  min-width: 120px;
}

.function-buttons button::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(102, 126, 234, 0.1), transparent);
  transition: left 0.5s ease;
}

.function-buttons button:hover::before {
  left: 100%;
}

.function-buttons button:hover {
  background: rgba(102, 126, 234, 0.1);
  border-color: #667eea;
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
}

.function-buttons button.active {
  background: linear-gradient(135deg, #667eea, #764ba2);
  border-color: transparent;
  color: white;
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
}

.refresh-button-container {
  display: flex;
  justify-content: flex-end;
  margin-bottom: 24px;
}

.refresh-button {
  background: linear-gradient(135deg, #667eea, #764ba2);
  color: white;
  border: none;
  padding: 12px 24px;
  border-radius: 25px;
  cursor: pointer;
  font-weight: 600;
  font-size: 14px;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  gap: 8px;
  box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
  position: relative;
  overflow: hidden;
}

.refresh-button::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
  transition: left 0.5s ease;
}

.refresh-button:hover:not(:disabled)::before {
  left: 100%;
}

.refresh-button:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(102, 126, 234, 0.5);
}

.refresh-button:disabled {
  background: linear-gradient(135deg, #cccccc, #999999);
  cursor: not-allowed;
  transform: none;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.status-message {
  padding: 16px 24px;
  margin: 16px 0;
  border-radius: 15px;
  text-align: center;
  font-weight: 600;
  font-size: 14px;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
  animation: slideInDown 0.3s ease-out;
}

@keyframes slideInDown {
  from {
    opacity: 0;
    transform: translateY(-20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.success {
  background: linear-gradient(135deg, rgba(76, 175, 80, 0.9), rgba(139, 195, 74, 0.9));
  color: white;
  border-color: rgba(76, 175, 80, 0.3);
}

.error {
  background: linear-gradient(135deg, rgba(244, 67, 54, 0.9), rgba(233, 30, 99, 0.9));
  color: white;
  border-color: rgba(244, 67, 54, 0.3);
}

.content-section {
  background: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(20px);
  border: 1px solid rgba(102, 126, 234, 0.1);
  border-radius: 24px;
  padding: 32px;
  margin-bottom: 32px;
  box-shadow:
    0 8px 32px rgba(0, 0, 0, 0.1),
    0 2px 8px rgba(102, 126, 234, 0.1);
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;
}

.content-section::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 4px;
  background: linear-gradient(90deg, #667eea, #764ba2);
  border-radius: 24px 24px 0 0;
}

.content-section:hover {
  transform: translateY(-4px);
  box-shadow:
    0 12px 40px rgba(0, 0, 0, 0.15),
    0 4px 12px rgba(102, 126, 234, 0.2);
}

.section-title {
  text-align: center;
  font-size: 28px;
  font-weight: 700;
  margin-bottom: 32px;
  color: #333;
  position: relative;
  padding-bottom: 16px;
}

.section-title::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 80px;
  height: 3px;
  background: linear-gradient(90deg, #667eea, #764ba2);
  border-radius: 2px;
}

.image-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 24px;
  padding: 8px;
}

.grid-item {
  display: flex;
  flex-direction: column;
}

.image-card {
  background: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(102, 126, 234, 0.1);
  border-radius: 20px;
  overflow: hidden;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
  height: 100%;
  display: flex;
  flex-direction: column;
  transition: all 0.3s ease;
  cursor: pointer;
  position: relative;
}

.image-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.05), rgba(118, 75, 162, 0.05));
  opacity: 0;
  transition: opacity 0.3s ease;
  pointer-events: none;
}

.image-card:hover::before {
  opacity: 1;
}

.image-card:hover {
  transform: translateY(-8px) scale(1.02);
  box-shadow: 0 12px 40px rgba(102, 126, 234, 0.2);
  border-color: rgba(102, 126, 234, 0.3);
}

.image-card img {
  width: 100%;
  height: 240px;
  object-fit: cover;
  display: block;
  transition: transform 0.3s ease;
  position: relative;
  z-index: 1;
}

.image-card:hover img {
  transform: scale(1.05);
}

.no-result {
  height: 240px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #f8f9fa, #e9ecef);
  color: #6c757d;
  font-style: italic;
  font-size: 16px;
  font-weight: 500;
  position: relative;
}

.no-result::before {
  content: '📷';
  font-size: 48px;
  opacity: 0.3;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -80px);
}

.no-data {
  grid-column: 1 / -1;
  height: 200px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.05), rgba(118, 75, 162, 0.05));
  backdrop-filter: blur(10px);
  border: 2px dashed rgba(102, 126, 234, 0.3);
  color: #667eea;
  font-size: 18px;
  font-weight: 600;
  border-radius: 20px;
  position: relative;
  animation: pulse 2s infinite;
}

.no-data::before {
  content: '📂';
  font-size: 48px;
  margin-bottom: 12px;
  opacity: 0.6;
}

@keyframes pulse {
  0%, 100% {
    opacity: 0.8;
  }
  50% {
    opacity: 1;
  }
}

.category-section {
  margin-bottom: 48px;
  padding-bottom: 32px;
  border-bottom: 1px solid rgba(102, 126, 234, 0.1);
  position: relative;
}

.category-section:last-child {
  border-bottom: none;
}

.category-title {
  font-size: 22px;
  font-weight: 700;
  color: #333;
  margin-bottom: 24px;
  padding-left: 20px;
  position: relative;
  display: flex;
  align-items: center;
}

.category-title::before {
  content: '';
  position: absolute;
  left: 0;
  top: 50%;
  transform: translateY(-50%);
  width: 4px;
  height: 24px;
  background: linear-gradient(135deg, #667eea, #764ba2);
  border-radius: 2px;
}

.category-title::after {
  content: '';
  flex: 1;
  height: 1px;
  background: linear-gradient(90deg, rgba(102, 126, 234, 0.3), transparent);
  margin-left: 16px;
}

/* 响应式设计 */
@media (max-width: 1200px) {
  .image-grid {
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 20px;
  }
}

@media (max-width: 768px) {
  .shouye-container {
    padding: 16px;
  }

  .image-grid {
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    gap: 16px;
  }

  .function-buttons {
    padding: 16px;
    gap: 8px;
  }

  .function-buttons button {
    min-width: 100px;
    padding: 10px 16px;
    font-size: 13px;
  }

  .content-section {
    padding: 24px;
    margin-bottom: 24px;
  }

  .section-title {
    font-size: 24px;
    margin-bottom: 24px;
  }

  .category-title {
    font-size: 20px;
    margin-bottom: 20px;
  }
}

@media (max-width: 480px) {
  .shouye-container {
    padding: 12px;
  }

  .image-grid {
    grid-template-columns: 1fr;
    gap: 12px;
  }

  .function-buttons {
    flex-direction: column;
    gap: 8px;
  }

  .function-buttons button {
    width: 100%;
    min-width: auto;
  }

  .content-section {
    padding: 20px;
    border-radius: 16px;
  }

  .section-title {
    font-size: 22px;
  }

  .category-title {
    font-size: 18px;
  }

  .image-card img {
    height: 200px;
  }

  .no-result {
    height: 200px;
  }
}

/* 加载动画 */
@keyframes shimmer {
  0% {
    background-position: -200px 0;
  }
  100% {
    background-position: calc(200px + 100%) 0;
  }
}

.loading-shimmer {
  background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
  background-size: 200px 100%;
  animation: shimmer 1.5s infinite;
}

/* 滚动条样式 */
::-webkit-scrollbar {
  width: 8px;
}

::-webkit-scrollbar-track {
  background: rgba(102, 126, 234, 0.1);
  border-radius: 4px;
}

::-webkit-scrollbar-thumb {
  background: linear-gradient(135deg, #667eea, #764ba2);
  border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
  background: linear-gradient(135deg, #5a6fd8, #6a4190);
}
</style>

