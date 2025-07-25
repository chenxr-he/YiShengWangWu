<template>
  <div class="lazy-image-container" @click="handleClick">
    <img
      v-if="loaded"
      :src="src"
      :alt="alt"
      class="lazy-image"
      @load="onImageLoaded"
      @error="onImageError"
    />
    <div v-else class="image-placeholder">
      <span class="loading-icon">⏳</span>
    </div>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue';

export default {
  name: 'LazyImage',
  props: {
    src: {
      type: String,
      required: true
    },
    alt: {
      type: String,
      default: '图片'
    }
  },
  emits: ['click'],
  setup(props, { emit }) {
    const loaded = ref(false);
    const error = ref(false);

    const onImageLoaded = () => {
      loaded.value = true;
    };

    const onImageError = () => {
      error.value = true;
      loaded.value = true; // 显示错误状态而不是加载中
    };

    // 传递点击事件
    const handleClick = () => {
      if (loaded.value && !error.value) {
        emit('click');
      }
    };

    onMounted(() => {
      // 预加载图片
      const img = new Image();
      img.src = props.src;
      img.onload = onImageLoaded;
      img.onerror = onImageError;
    });

    return {
      loaded,
      error,
      onImageLoaded,
      onImageError,
      handleClick
    };
  }
}
</script>

<style scoped>
.lazy-image-container {
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  position: relative;
}

.lazy-image {
  max-width: 100%;
  max-height: 100%;
  object-fit: contain;
  transition: all 0.3s ease;
}

.image-placeholder {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100%;
  min-height: 150px;
  background: rgba(0, 0, 0, 0.05);
  border-radius: 8px;
}

.loading-icon {
  font-size: 32px;
  opacity: 0.5;
  animation: spin 1.5s linear infinite;
}

@keyframes spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}
</style>