<template>
  <div class="edit-view">
    <!-- 顶部导航栏 -->
    <div class="top-nav">
      <div class="nav-left">
        <el-icon class="logo-icon" :size="32" color="#ffffff">
          <Platform />
        </el-icon>
        <h2>一生万物・AI 图像梦工坊</h2>
      </div>
      <div class="user-info">
        <div class="avatar">
          <el-icon  :size="32"  color="#ffffff"   @click="$router.push({path:'/edit/ge-ren-zhu-ye',query:{t:Date.now()}})"  style="cursor: pointer;" >
            <img :src="Constant.userInfo.avatar" 
                  style="
                  width: 100%; 
                  height: 100%; 
                  border-radius: 100%; 
                  object-fit: cover;
                  position: absolute;
                  top: 0;
                  left: 0;
                  "
                >
            <User />
          </el-icon>
        </div>
        <!-- 下拉菜单 -->
        <el-dropdown @command="handleCommand" trigger="click">
          <div class="dropdown-trigger">
            <span class="username">{{ Constant.userInfo.userID }}</span>
            <el-icon class="arrow-icon" :size="12" color="#ffffff">
              <ArrowDown />
            </el-icon>
          </div>
          <template #dropdown>
            <el-dropdown-menu>
              <el-dropdown-item command="changePassword" divided>
                <el-icon><Lock /></el-icon>
                <span>修改密码</span>
              </el-dropdown-item>
              <el-dropdown-item command="logout" divided>
                <el-icon><SwitchButton /></el-icon>
                <span>退出登录</span>
              </el-dropdown-item>
              <el-dropdown-item command="VIP" divided>
                <el-icon><Star /></el-icon>
                <span>开通会员</span>
              </el-dropdown-item>
            </el-dropdown-menu>
          </template>
        </el-dropdown>
      </div>
    </div>

    <!-- 修改密码对话框 -->
    <el-dialog
      v-model="changePasswordDialogVisible"
      title="修改密码"
      width="420px"
      :before-close="handleCloseDialog"
      center
    >
      <el-form
        ref="passwordFormRef"
        :model="passwordForm"
        :rules="passwordRules"
        label-width="80px"
        size="large"
      >
        <el-form-item label="原密码" prop="password">
          <el-input
            v-model="passwordForm.password"
            type="password"
            placeholder="请输入原密码"
            :prefix-icon="Lock"
            show-password
            clearable
          />
        </el-form-item>
        <el-form-item label="新密码" prop="newPassword">
          <el-input
            v-model="passwordForm.newPassword"
            type="password"
            placeholder="请输入新密码"
            :prefix-icon="Lock"
            show-password
            clearable
          />
        </el-form-item>
        <el-form-item label="确认密码" prop="checkNewPassword">
          <el-input
            v-model="passwordForm.checkNewPassword"
            type="password"
            placeholder="请再次输入新密码"
            :prefix-icon="Lock"
            show-password
            clearable
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="changePasswordDialogVisible = false">取消</el-button>
          <el-button type="primary" @click="changePassword" :loading="passwordLoading">
            保存
          </el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 会员开通对话框 -->
    <el-dialog
      v-model="vipDialogVisible"
      title="开通会员"
      width="380px"
      center
    >
      <div class="vip-content">
        <img src="@/assets/dashang.jpg" alt="支付二维码" class="vip-qrcode">
        <p class="vip-tip">请支付20元开通会员</p>
      </div>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="vipDialogVisible = false">取消</el-button>
          <el-button type="primary" @click="confirmVip">已支付完成</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 左侧菜单和右侧内容区域 -->
    <div class="main-content">
      <div class="menu">
        <el-menu
          :default-active="currentView"
          class="sidebar-menu"
          @select="handleMenuSelect"
          background-color="transparent"
          text-color="#333"
          active-text-color="#667eea"
        >
          <el-menu-item index="shou-ye">
            <el-icon><HomeFilled /></el-icon>
            <span>首页</span>
          </el-menu-item>
          <el-menu-item index="xu-ni-huan-yi">
            <el-icon><Handbag /></el-icon>
            <span>虚拟换衣</span>
          </el-menu-item>
          <el-menu-item index="wen-sheng-tu">
            <el-icon><Picture /></el-icon>
            <span>文生图</span>
          </el-menu-item>
          <el-menu-item index="ren-lian-feng-ge-hua">
            <el-icon><Brush /></el-icon>
            <span>人脸风格化</span>
          </el-menu-item>
          <el-menu-item index="ren-lian-xiao-xiang">
            <el-icon><Avatar /></el-icon>
            <span>人脸肖像</span>
          </el-menu-item>
          <el-menu-item index="zhi-neng-kou-tu">
            <el-icon><Crop /></el-icon>
            <span>智能抠图</span>
          </el-menu-item>
          <el-menu-item index="li-shi-ji-lu">
            <el-icon><Clock /></el-icon>
            <span>历史记录</span>
          </el-menu-item>
          <el-menu-item index="ge-ren-zhu-ye">
            <el-icon><HomeFilled /></el-icon>
            <span>个人主页</span>
          </el-menu-item>
        </el-menu>
      </div>

      <!-- 右侧内容 -->
      <div class="content">
        <!-- 条件渲染 -->
        <div v-if="currentView === 'shou-ye'">
          <ShouYe />
        </div>
        <div v-if="currentView==='ge-ren-zhu-ye'">
          <GeRenZhuYe/>
        </div>
        <div v-if="currentView === 'xu-ni-huan-yi'">
          <XuNiHuanYi />
        </div>
        <div v-if="currentView === 'wen-sheng-tu'">
          <WenShengTu />
        </div>
        <div v-if="currentView === 'ren-lian-feng-ge-hua'">
          <RenLianFengGeHua />
        </div>
        <div v-if="currentView === 'ren-lian-xiao-xiang'">
          <RenLianXiaoXiang />
        </div>
        <div v-if="currentView === 'zhi-neng-kou-tu'">
          <ZhiNengKouTu />
        </div>
        <div v-if="currentView === 'li-shi-ji-lu'">
          <LiShiJiLu />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ElMessage, ElMessageBox } from 'element-plus'
import {
  Platform, User, ArrowDown, Lock, SwitchButton,
  HomeFilled, Handbag, Picture, Brush, Avatar, Crop, Clock,Star
} from '@element-plus/icons-vue'
import ShouYe from './ShouYe.vue'
import XuNiHuanYi from './XuNiHuanYi.vue'
import WenShengTu from './WenShengTu.vue'
import RenLianFengGeHua from './RenLianFengGeHua.vue'
import RenLianXiaoXiang from './RenLianXiaoXiang.vue'
import ZhiNengKouTu from './ZhiNengKouTu.vue'
import LiShiJiLu from './LiShiJiLu.vue'
import * as Constant from '@/GlobalInfo'
//import axios from 'axios'
import { BASE_URL } from '@/config'
import GeRenZhuYe from './GeRenZhuYe.vue'

export default {
  name: 'EditView',
  components: {
    ShouYe,
    XuNiHuanYi,
    WenShengTu,
    RenLianFengGeHua,
    RenLianXiaoXiang,
    ZhiNengKouTu,
    LiShiJiLu,
    GeRenZhuYe,
    // Element Plus 图标
    Platform,
    User,
    ArrowDown,
    Lock,
    SwitchButton,
    HomeFilled,
    Handbag,
    Picture,
    Brush,
    Avatar,
    Crop,
    Clock,
    Star
  },
  data() {
    return {
      Constant,
      currentView: 'shou-ye',
      changePasswordDialogVisible: false,
      vipDialogVisible: false, 
      passwordLoading: false,
      passwordFormRef: null,
      passwordForm: {
        email: localStorage.getItem('email') || '',
        password: '',
        newPassword: '',
        checkNewPassword: ''
      },
      passwordRules: {
        password: [
          { required: true, message: '请输入原密码', trigger: 'blur' }
        ],
        newPassword: [
          { required: true, message: '请输入新密码', trigger: 'blur' },
          { min: 6, message: '密码长度不能少于6位', trigger: 'blur' }
        ],
        checkNewPassword: [
          { required: true, message: '请确认新密码', trigger: 'blur' },
          { validator: this.validateConfirmPassword, trigger: 'blur' }
        ]
      }
    };
  },
  methods:{
    // 验证确认密码
    validateConfirmPassword(_, value, callback) {
      if (value === '') {
        callback(new Error('请再次输入密码'))
      } else if (value !== this.passwordForm.newPassword) {
        callback(new Error('两次输入密码不一致'))
      } else {
        callback()
      }
    },
    // 处理下拉菜单命令
    handleCommand(command) {
      if (command === 'changePassword') {
        this.showChangePasswordDialog()
      } else if (command === 'logout') {
        this.logout()
      }else if(command=="VIP"){
        this.VIP()
      }
    },
    // 处理菜单选择
    handleMenuSelect(index) {
      this.currentView = index
      /this.$router.push({path:`/edit/${index}`,query:{t:Date.now()}}) 
    },
    // 显示修改密码对话框
    showChangePasswordDialog() {
      this.changePasswordDialogVisible = true;
      this.passwordForm.password = '';
      this.passwordForm.newPassword = '';
      this.passwordForm.checkNewPassword = '';
    },
    // 关闭对话框
    handleCloseDialog() {
      this.changePasswordDialogVisible = false;
      this.$refs.passwordFormRef?.resetFields();
    },
    // 修改密码方法
    async changePassword() {
      if (!this.$refs.passwordFormRef) return;

      await this.$refs.passwordFormRef.validate(async (valid) => {
        if (valid) {
          this.passwordLoading = true;
          try {
              try {
                const response1 = await fetch(BASE_URL, {
                  method: 'GET',
                  headers: {
                    'type': 'PassWordChange',
                    'new_passwd':this.passwordForm.newPassword,
                    'password':this.passwordForm.password
                  },
                  credentials: 'include',
                });
                const data = await response1.json(); 
                const msg=data["msg"]
                const status=data["status"]
                if (response1.status === 200&&status==true) {
                  ElMessage.success("修改密码成功!");
                } else {
                  ElMessage.error(msg  || '修改密码失败')
                }
              } catch (error) {
                ElMessage.error("网络异常！")
                this.showChangePasswordDialog();
              }
          } catch (error) {
            ElMessage.error("请检查原密码是否正确！");
          } finally {
            this.passwordLoading = false;
          }
        } else {
          ElMessage.warning('请正确填写密码信息');
        }
      });
    },
    // 显示对话框
    async VIP(){
      this.vipDialogVisible = true;
    },
    async confirmVip(){
      try{
        const resp=await fetch(BASE_URL,{
          method:'GET',
          headers:{
            'type':"VIP"
          },
          credentials: 'include',
        });
        const data=await resp.json()
        const status=data["status"]
        const msg=data["msg"]
        if(resp.status===200&&status===true){
           ElMessage.success(msg)
           Constant.userInfo.vipStatus=true
           this.vipDialogVisible = false 
        }else{
           ElMessage.warning(msg)
        }
      }catch(error){
        ElMessage.error("网络异常！")
      }
    },
    logout() {
      ElMessageBox.confirm(
        '确定要退出登录吗？',
        '提示',
        {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning',
        }
      ).then(() => {
        Constant.userInfo.email=''
        Constant.userInfo.userID=''
        ElMessage.success("退出成功");
        this.$router.push('/login');
      }).catch(() => {
        // 用户取消退出
      });
    }
  },
  // 监听路由变化
  watch: {
    // 监听路由变化
    '$route'(to) {
      // 从路径中提取当前视图名称
      const path = to.path;
      // 提取最后一部分作为当前视图
      const viewMatch = path.match(/\/edit\/([^/]+)$/);
      if (path === '/edit') {
        // 如果是编辑页面根路径，显示首页
        this.currentView = 'shou-ye';
        console.log('路由变化，显示首页');
      }
      else if (viewMatch && viewMatch[1]) {
        this.currentView = viewMatch[1];
        console.log('路由变化，当前视图更新为:', this.currentView);
      } 
    }
  },
  // 添加 mounted 钩子进行初始化
  mounted() {
    // 初始化时根据当前路由设置视图
    const path = this.$route.path;
    const viewMatch = path.match(/\/edit\/([^/]+)$/);
    console.log('路由变化，当前路径:', path, '匹配结果:', viewMatch);
    if (path === '/edit') {
      // 如果是编辑页面根路径，显示首页
      this.currentView = 'shou-ye';
      console.log('默认显示首页');
    }
    else if (viewMatch && viewMatch[1]) {
      // 仅当匹配到特定子路由时更改视图
      if (viewMatch[1] !== 'shou-ye') {  // 如果不是首页路径
        this.currentView = viewMatch[1];
        console.log('初始视图设置为:', this.currentView);
      }
    } 
    }
}
</script>

<style scoped>
.edit-view {
  display: flex;
  flex-direction: column;
  height: 100vh;
  font-family: 'Arial', sans-serif;
  color: #333;
}

.top-nav {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background: linear-gradient(135deg, #667eea, #764ba2);
  color: white;
  padding: 0 24px;
  height: 80px;
  width: 100%;
  box-shadow: 0 4px 20px rgba(102, 126, 234, 0.3);
  position: relative;
  z-index: 100;
}

.nav-left {
  display: flex;
  align-items: center;
  gap: 16px;
}

.logo-icon {
  animation: rotate 3s linear infinite;
}

@keyframes rotate {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}

.top-nav h2 {
  font-size: 24px;
  font-weight: 600;
  letter-spacing: 0.5px;
  margin: 0;
  background: linear-gradient(45deg, #ffffff, #f0f8ff);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.user-info {
  display: flex;
  align-items: center;
  gap: 16px;
}

.avatar {
  width: 42px;
  height: 42px;
  border-radius: 50%;
  background: linear-gradient(135deg, rgba(255, 255, 255, 0.2), rgba(255, 255, 255, 0.1));
  backdrop-filter: blur(10px);
  border: 2px solid rgba(255, 255, 255, 0.3);
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-weight: bold;
  font-size: 16px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
  transition: all 0.3s ease;
}

.avatar:hover {
  transform: scale(1.05);
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
}

.dropdown-trigger {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 8px 16px;
  border-radius: 20px;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  transition: all 0.3s ease;
  cursor: pointer;
}

.dropdown-trigger:hover {
  background: rgba(255, 255, 255, 0.2);
  transform: translateY(-1px);
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
}

.username {
  font-size: 15px;
  font-weight: 500;
  color: white;
}

.arrow-icon {
  transition: transform 0.3s ease;
}

/* Element Plus 下拉菜单样式覆盖 */
:deep(.el-dropdown-menu) {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(20px);
  border: 1px solid rgba(102, 126, 234, 0.2);
  border-radius: 12px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
  padding: 8px;
}

:deep(.el-dropdown-menu__item) {
  border-radius: 8px;
  margin: 2px 0;
  padding: 10px 16px;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  gap: 8px;
}

:deep(.el-dropdown-menu__item:hover) {
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
  color: #667eea;
  transform: translateX(2px);
}

:deep(.el-dropdown-menu__item.is-divided) {
  border-top: 1px solid rgba(102, 126, 234, 0.1);
  margin-top: 8px;
  padding-top: 12px;
}

/* Element Plus 对话框样式覆盖 */
:deep(.el-dialog) {
  margin-top: 27vh !important; /* 增加顶部间距，默认通常是15vh */
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(20px);
  border: 1px solid rgba(102, 126, 234, 0.2);
  border-radius: 20px;
  box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
}

:deep(.el-dialog__header) {
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
  border-radius: 20px 20px 0 0;
  padding: 20px 24px;
}

:deep(.el-dialog__title) {
  color: #667eea;
  font-weight: 600;
  font-size: 18px;
}

:deep(.el-dialog__body) {
  padding: 24px;
}

:deep(.el-form-item__label) {
  color: #333;
  font-weight: 500;
}

:deep(.el-input__wrapper) {
  border-radius: 12px;
  border: 1px solid rgba(102, 126, 234, 0.2);
  transition: all 0.3s ease;
}

:deep(.el-input__wrapper:hover) {
  border-color: #667eea;
  box-shadow: 0 2px 8px rgba(102, 126, 234, 0.2);
}

:deep(.el-input__wrapper.is-focus) {
  border-color: #667eea;
  box-shadow: 0 0 0 2px rgba(102, 126, 234, 0.2);
}

:deep(.el-button--primary) {
  background: linear-gradient(135deg, #667eea, #764ba2);
  border: none;
  border-radius: 12px;
  transition: all 0.3s ease;
}

:deep(.el-button--primary:hover) {
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
}

.main-content {
  display: flex;
  flex: 1;
  overflow: hidden;
}

.menu {
  width: 240px;
  background: linear-gradient(180deg, #f8f9fa 0%, #ffffff 100%);
  padding: 24px 0;
  overflow-y: auto;
  border-right: 1px solid rgba(102, 126, 234, 0.1);
  box-shadow: 2px 0 10px rgba(0, 0, 0, 0.05);
}

/* Element Plus 菜单样式覆盖 */
.sidebar-menu {
  border: none;
  background: transparent;
}

:deep(.el-menu-item) {
  margin: 4px 16px;
  border-radius: 12px;
  transition: all 0.3s ease;
  font-size: 16px;
  font-weight: 500;
  height: 48px;
  line-height: 48px;
  position: relative;
  overflow: hidden;
}

:deep(.el-menu-item::before) {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(102, 126, 234, 0.1), transparent);
  transition: left 0.5s ease;
}

:deep(.el-menu-item:hover::before) {
  left: 100%;
}

:deep(.el-menu-item:hover) {
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.05));
  transform: translateX(4px);
  box-shadow: 0 4px 15px rgba(102, 126, 234, 0.2);
}

:deep(.el-menu-item.is-active) {
  background: linear-gradient(135deg, #667eea, #764ba2);
  color: white !important;
  transform: translateX(6px);
  box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
}

:deep(.el-menu-item.is-active .el-icon) {
  color: white;
}

:deep(.el-menu-item .el-icon) {
  margin-right: 12px;
  font-size: 18px;
  transition: all 0.3s ease;
}

.content {
  flex-grow: 1;
  padding: 24px;
  background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 50%, #f0f8ff 100%);
  overflow-y: auto;
  position: relative;
}

.content::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background:
    radial-gradient(circle at 20% 20%, rgba(102, 126, 234, 0.05) 0%, transparent 50%),
    radial-gradient(circle at 80% 80%, rgba(118, 75, 162, 0.05) 0%, transparent 50%);
  pointer-events: none;
}

.content > div {
  position: relative;
  z-index: 1;
  background: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(102, 126, 234, 0.1);
  border-radius: 20px;
  padding: 32px;
  box-shadow:
    0 8px 32px rgba(0, 0, 0, 0.1),
    0 2px 8px rgba(102, 126, 234, 0.1);
  min-height: calc(100vh - 200px);
  transition: all 0.3s ease;
}

.content > div:hover {
  transform: translateY(-2px);
  box-shadow:
    0 12px 40px rgba(0, 0, 0, 0.15),
    0 4px 12px rgba(102, 126, 234, 0.2);
}

/* 响应式设计 */
@media (max-width: 768px) {
  .main-content {
    flex-direction: column;
  }

  .menu {
    width: 100%;
    height: auto;
    padding: 16px 0;
  }

  .content {
    padding: 16px;
  }

  .content > div {
    padding: 20px;
    min-height: auto;
  }

  .top-nav {
    padding: 0 16px;
    height: 70px;
  }

  .nav-left h2 {
    font-size: 18px;
  }
}

/* 会员对话框 */
.vip-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 10px;
}

.vip-qrcode {
  width: 240px;
  height: 240px;
  object-fit: cover;
  border-radius: 10px;
  box-shadow: 0 4px 12px rgba(102, 126, 234, 0.2);
  transition: transform 0.3s ease;
}

.vip-qrcode:hover {
  transform: scale(1.02);
}

.vip-tip {
  margin-top: 20px;
  font-size: 16px;
  font-weight: 500;
  color: #667eea;
  text-align: center;
}
</style>
