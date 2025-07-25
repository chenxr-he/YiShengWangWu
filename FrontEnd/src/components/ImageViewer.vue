<template>
  <transition name="fade">
    <div v-if="visible" class="image-viewer-overlay" @click.self="closeViewer">
      <div class="image-viewer-container">
        <div class="image-viewer-header">
          <h3 v-if="title" class="image-viewer-title">{{ title }}</h3>
          <div class="image-viewer-actions">
            <button class="action-button zoom-in" @click="zoomIn">
              <span>放大</span>
            </button>
            <button class="action-button zoom-out" @click="zoomOut">
              <span>缩小</span>
            </button>
            <button class="action-button reset" @click="resetZoom">
              <span>重置</span>
            </button>
            <button class="action-button download" @click="downloadImage">
              <span>下载</span>
            </button>
            <button class="action-button close" @click="closeViewer">
              <span>关闭</span>
            </button>
          </div>
        </div>
        <div class="image-viewer-content" ref="imageContainer">
          <img
            :src="imageSrc"
            :alt="title || '查看图片'"
            :style="{ transform: `scale(${zoom})` }"
            @wheel.prevent="handleWheel"
            @mousedown="startDrag"
            @mouseup="stopDrag"
            @mousemove="dragImage"
            @mouseleave="stopDrag"
            ref="viewerImage"
          />
        </div>
      </div>
    </div>
  </transition>
</template>

<script>
//import { BASE_URL } from '@/config';
import { ref, watch } from 'vue';

export default {
  name: 'ImageViewer',
  props: {
    visible: {
      type: Boolean,
      default: false
    },
    imageSrc: {
      type: String,
      required: true
    },
    title: {
      type: String,
      default: ''
    }
  },
  emits: ['close'],
  setup(props, { emit }) {
    const zoom = ref(1);
    const isDragging = ref(false);
    const lastPosition = ref({ x: 0, y: 0 });
    const imagePosition = ref({ x: 0, y: 0 });
    const viewerImage = ref(null);
    const imageContainer = ref(null);

    // 新增：下载图片功能
    const downloadImage =  async () => {
      console.log(props.imageSrc)
      const parts=props.imageSrc.split("/")
      const fileName = parts[parts.length-1]
      try {
        // 发起请求
        const response = await fetch(props.imageSrc, {
          method: 'GET',
          credentials:'include'
        });

        // 检查请求是否成功
        if (!response.ok) {
          throw new Error(`下载失败: ${response.status} ${response.statusText}`);
        }

        // 将响应转换为Blob对象
        const blob = await response.blob();
        // 创建临时URL
        const objectUrl = URL.createObjectURL(blob);

        // 创建a标签触发下载
        const link = document.createElement('a');
        link.href = objectUrl;
        link.download = fileName; 
        link.click();
        // 清理资源
        setTimeout(() => {
          URL.revokeObjectURL(objectUrl); 
        }, 100);
      }catch(e){
        console.log(e)
      }
    };

    // 放大
    const zoomIn = () => {
      zoom.value = Math.min(zoom.value + 0.25, 3);
    };

    // 缩小
    const zoomOut = () => {
      zoom.value = Math.max(zoom.value - 0.25, 0.5);
    };

    // 重置缩放
    const resetZoom = () => {
      zoom.value = 1;
      imagePosition.value = { x: 0, y: 0 };
      if (viewerImage.value) {
        viewerImage.value.style.transform = `scale(${zoom.value})`;
        viewerImage.value.style.left = '0px';
        viewerImage.value.style.top = '0px';
      }
    };

    // 关闭查看器
    const closeViewer = () => {
      emit('close');
      resetZoom();
    };

    // 鼠标滚轮缩放
    const handleWheel = (event) => {
      if (event.deltaY < 0) {
        zoomIn();
      } else {
        zoomOut();
      }
    };

    // 开始拖拽
    const startDrag = (event) => {
      if (zoom.value > 1) {
        isDragging.value = true;
        lastPosition.value = {
          x: event.clientX,
          y: event.clientY
        };
      }
    };

    // 停止拖拽
    const stopDrag = () => {
      isDragging.value = false;
    };

    // 拖拽图片
    const dragImage = (event) => {
      if (isDragging.value && viewerImage.value) {
        const deltaX = event.clientX - lastPosition.value.x;
        const deltaY = event.clientY - lastPosition.value.y;

        imagePosition.value = {
          x: imagePosition.value.x + deltaX,
          y: imagePosition.value.y + deltaY
        };

        viewerImage.value.style.left = `${imagePosition.value.x}px`;
        viewerImage.value.style.top = `${imagePosition.value.y}px`;

        lastPosition.value = {
          x: event.clientX,
          y: event.clientY
        };
      }
    };
    watch(() => props.visible, (isVisible) => {
      if (isVisible) {
        document.body.style.overflow = 'hidden';
      } else {
        document.body.style.overflow = '';
        resetZoom();
      }
    });
    return {
      zoom,
      viewerImage,
      imageContainer,
      zoomIn,
      zoomOut,
      resetZoom,
      closeViewer,
      handleWheel,
      startDrag,
      stopDrag,
      dragImage,
      downloadImage  
    };
  }
}
</script>

<style scoped>
.image-viewer-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.85);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 9999;
  padding: 24px;
}

.image-viewer-container {
  width: 90%;
  height: 90%;
  background-color: rgba(0, 0, 0, 0.3);
  border-radius: 12px;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.5);
}

.image-viewer-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 24px;
  background-color: rgba(0, 0, 0, 0.7);
  backdrop-filter: blur(10px);
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.image-viewer-title {
  color: white;
  margin: 0;
  font-size: 18px;
  font-weight: 600;
}

.image-viewer-actions {
  display: flex;
  gap: 12px;
}

.action-button {
  background-color: rgba(255, 255, 255, 0.15);
  border: none;
  color: white;
  padding: 8px 12px;
  border-radius: 8px;
  cursor: pointer;
  font-size: 14px;
  transition: all 0.2s ease;
  display: flex;
  align-items: center;
  gap: 6px;
}

.action-button:hover {
  background-color: rgba(255, 255, 255, 0.25);
}

/* 下载按钮样式 */
.action-button.download {
  background-color: rgba(40, 167, 69, 0.3);
}

.action-button.download:hover {
  background-color: rgba(40, 167, 69, 0.5);
}

.close {
  background-color: rgba(220, 53, 69, 0.3);
}

.close:hover {
  background-color: rgba(220, 53, 69, 0.5);
}

.image-viewer-content {
  flex: 1;
  display: flex;
  justify-content: center;
  align-items: center;
  overflow: hidden;
  position: relative;
}

.image-viewer-content img {
  max-width: 100%;
  max-height: 100%;
  object-fit: contain;
  transition: transform 0.2s ease;
  position: relative;
  cursor: zoom-in;
}

.fade-enter-active, .fade-leave-active {
  transition: opacity 0.3s;
}

.fade-enter-from, .fade-leave-to {
  opacity: 0;
}
</style>