<template>
  <div class="profile-container">
    <div class="profile-card">
      <!-- 头像和基本信息区域 -->
      <div class="profile-header">
        <div class="avatar-container" @click="triggerFileInput">
          <img :src="Constant.userInfo.avatar" alt="用户头像" class="avatar">
          <div class="edit-overlay">点击修改头像</div>
          <input type="file" class="file-input" ref="fileInput" @change="changeAvatar" accept="image/*">
        </div>
        
        <div class="user-info">
          <div class="nickname">
            <h2>{{ Constant.userInfo.userID }}</h2>
            <button class="edit-btn" @click="editNicknameDialog = true">
              <el-icon><Edit /></el-icon>
            </button>
          </div>
          
          <!-- 基本信息展示 -->
          <div class="basic-info">
            <div class="info-item">
              <span class="info-label">绑定邮箱：</span>
              <span class="info-content">{{ Constant.userInfo.email }}</span>
            </div>
            <div class="info-item">
              <span class="info-label">注册时间：</span>
              <span class="info-content">{{ Constant.userInfo.registDate }}</span>
            </div>
            <div class="info-item">
              <span class="info-label">会员状态：</span>
              <span class="membership-badge">
                {{ Constant.userInfo.vipStatus?"高级":"未开通" }}会员
              </span>
            </div>
          </div>
        </div>
      </div>
      
      <!-- 会员详情区域 -->
      <div class="membership-section">
        <div class="section-header">
          <el-icon><Star /></el-icon>
          <h3>会员详情</h3>
        </div>
        
        <div class="membership-details">
            <div class="detail-item">
            <span class="detail-label">开通时间</span>
            <span class="detail-value">{{ Constant.userInfo.vip_start_time }}</span>
          </div>
          <div class="detail-item">
            <span class="detail-label">有效期至</span>
            <span class="detail-value">{{ Constant.userInfo.vip_end_time }}</span>
          </div>
          
          <div class="detail-item">
            <span class="detail-label">会员特权</span>
            <span class="detail-value">无限创作 · 高清导出 · 优先体验</span>
          </div>
          
          <button class="upgrade-btn" @click="upgradeMembership">
            {{ Constant.userInfo.vipStatus?"续费会员":"开通会员" }}
          </button>
        </div>
      </div>
      
      <!-- 建议反馈区域 -->
      <div class="feedback-section">
        <div class="section-header">
          <el-icon><Message /></el-icon>
          <h3>建议反馈</h3>
        </div>
        
        <div class="feedback-content">
          <el-input
            v-model="feedbackContent"
            type="textarea"
            :rows="4"
            placeholder="请输入您的建议或反馈..."
            maxlength="500"
            show-word-limit
          ></el-input>
          
          <button 
            class="submit-feedback-btn" 
            @click="submitFeedback"
            :disabled="!feedbackContent.trim()"
          >
            提交建议
          </button>
        </div>
      </div>
      
      <!-- 账号管理区域 -->
      <div class="account-management">
        <div class="section-header">
          <el-icon><Setting /></el-icon>
          <h3>账号管理</h3>
        </div>
        
        <div class="account-actions">
          <button class="delete-account-btn" @click="showDeleteConfirm = true">
            <el-icon><Delete /></el-icon>
            注销账号
          </button>
        </div>
      </div>
    </div>
    
    <!-- 修改昵称对话框 -->
    <el-dialog
      v-model="editNicknameDialog"
      title="修改昵称"
      width="400px"
      center
    >
      <el-input 
        v-model="tempNickname" 
        placeholder="请输入新昵称" 
        size="large"
        maxlength="20"
        show-word-limit
      />
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="editNicknameDialog = false">取消</el-button>
          <el-button type="primary" @click="saveNickname">保存</el-button>
        </span>
      </template>
    </el-dialog>
    
    <!-- 会员开通对话框 -->
    <el-dialog
      v-model="vipDialog"
      :title="Constant.userInfo.vipStatus?'续费会员':'开通会员'"
      width="500px"
      center
    >
      <div class="vip-content">
        <div class="vip-plans">
          <div 
            v-for="plan in membershipPlans" 
            :key="plan.id"
            class="vip-plan"
            :class="{ 'active': selectedPlan === plan.id }"
            @click="selectedPlan = plan.id"
          >
            <h3>{{ plan.name }}</h3>
            <div class="price">{{ plan.price }}</div>
            <div class="duration">{{ plan.duration }}</div>
            <ul class="features">
              <li v-for="(feature, index) in plan.features" :key="index">{{ feature }}</li>
            </ul>
          </div>
        </div>
      </div>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="vipDialog = false">取消</el-button>
          <el-button type="primary" @click="confirmMembership">立即开通</el-button>
        </div>
      </template>
    </el-dialog>
    
    <!-- 注销账号确认对话框 - 修改为密码输入 -->
    <el-dialog
      v-model="showDeleteConfirm"
      title="注销账号"
      width="450px"
      center
      :close-on-click-modal="false"
    >
      <div class="delete-confirm-content">
        <div class="warning-icon">
          <el-icon><Warning /></el-icon>
        </div>
        <div class="warning-text">
          <p>您确定要注销当前账号吗？</p>
          <p class="danger-note">注销后，所有数据（包括会员信息、创作内容等）将被永久删除，且无法恢复！</p>
          
          <!-- 改为密码输入框 -->
          <el-input
            v-model="confirmPassword"
            type="password"
            placeholder="请输入您的密码以确认"
            class="confirm-input"
            :disabled="deleteLoading"
            show-password
          />
        </div>
      </div>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="showDeleteConfirm = false" :disabled="deleteLoading">取消</el-button>
          <el-button 
            type="danger" 
            @click="deleteAccount"
            :loading="deleteLoading"
            :disabled="!confirmPassword || deleteLoading"
          >
            确认注销
          </el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script>
import { Edit, Star, Message, Setting, Delete, Warning } from '@element-plus/icons-vue';
import { onMounted, ref } from 'vue';
import { ElMessage, ElMessageBox } from 'element-plus';
import { BASE_URL } from '@/config';
import  * as Constant  from '@/GlobalInfo';
import { useRouter } from 'vue-router';
//import { cosh } from 'core-js/core/number';

export default {
  name: 'GeRenZhuYe',
  components: {
    Edit,
    Star,
    Message,
    Setting,
    Delete,
    Warning
  },
    setup() {
    const router = useRouter();
    
    const tempNickname = ref('');
    const editNicknameDialog = ref(false);
    const vipDialog = ref(false);
    const selectedPlan = ref(2);
    const fileInput = ref(null);
    const feedbackContent = ref('');
    const feedbackLoading = ref(false);
    const showDeleteConfirm = ref(false);
    const confirmPassword = ref('');  
    const deleteLoading = ref(false);
    
    // 会员套餐数据
    const membershipPlans = ref([
      {
        id: 1,
        name: '月度会员',
        price: '¥29',
        duration: '1个月',
        features: ['每日100次创作', '高清图像导出', '10个专属模板']
      },
      {
        id: 2,
        name: '年度会员',
        price: '¥199',
        duration: '12个月',
        features: ['无限次创作', '超高清图像导出', '50+专属模板', '优先体验新功能']
      },
      {
        id: 3,
        name: '终身会员',
        price: '¥599',
        duration: '永久',
        features: ['无限次创作', '超高清图像导出', '所有专属模板', '终身功能更新', '专属客服']
      }
    ]);
    
    // 触发头像上传
    const triggerFileInput = () => {
      fileInput.value.click();
    };
    
    // 更换头像处理
    const changeAvatar = async  (event) => {
      const file = event.target.files[0];
      if (file) {
        try{
            const formData1 = new FormData();
            formData1.append('custom_image', file);
            console.log(file.value)
            const resp=await fetch(BASE_URL,{
                method:'POST',
                headers:{
                    "type":"avatarChange"
                },
                credentials:'include',
                body:formData1,
            })
            const data=await resp.json()
            console.log(data)
            if(resp.status==200&&data["status"]==true){
                Constant.userInfo.avatar=BASE_URL+data["new_avatar"]
                ElMessage.success('头像修改成功！');
            }else{
                ElMessage.error("修改失败")
            }
        }catch(e){
            ElMessage.error("网络异常")
        }
      }
    };
    
    // 保存昵称修改
    const saveNickname = async () => {
      if (tempNickname.value.trim()) {
        try{
            const resp=await fetch(BASE_URL,{
                method:'POST',
                headers:{
                    "type":"userIDChange",
                    "Content-Type": "application/json"
                },
                body:JSON.stringify({
                  userID:tempNickname.value
                }),
                credentials:'include'
            })
            const data=await resp.json()
            if(resp.status==200&&data["status"]==true){
                Constant.userInfo.userID=tempNickname.value
                ElMessage.success('昵称修改成功！');
                editNicknameDialog.value = false;
            }else{
                ElMessage.error("修改失败")
            }
        }catch(e){
            ElMessage.error("网络异常")
        }
        
      }
    };
    
    // 打开会员升级对话框
    const upgradeMembership = async() => {
      vipDialog.value = true;
    };
    
    // 确认会员购买
    const confirmMembership = async() => {
      try {
        const resp = await fetch(BASE_URL, {
          method: 'GET',
          headers: {
            'type': "VIP"
          },
          credentials: 'include',
        });
        
        const data = await resp.json();
        const status = data["status"];
        const msg = data["msg"];
        console.log("会员开通响应:", data);
        if (resp.status === 200 && status === true) {
          // 更新会员信息
          Constant.userInfo.vipStatus = true;
          
          // 重新加载用户信息以获取最新的会员开通时间和到期时间
          await LoadUserInfo();
          
          vipDialog.value = false;
          ElMessage.success(msg || '会员开通成功！');
        } else {
          ElMessage.warning(msg || '开通失败，请稍后再试');
        }
      } catch (error) {
        console.error("会员开通错误:", error);
        ElMessage.error("网络异常，请稍后再试");
      }
    };
    
    // 提交建议反馈
    const submitFeedback = async () => {
      if (!feedbackContent.value.trim()) return;
      
      feedbackLoading.value = true;
      try {
        const resp = await fetch(BASE_URL, {
          method: 'POST',
          headers: {
            "type": "UserFeedback",
            "Content-Type": "application/json"
          },
          body: JSON.stringify({
            content: feedbackContent.value,
          }),
          credentials: 'include'
        });
        
        const data = await resp.json();
        if (resp.status === 200 && data["status"] === true) {
          ElMessage.success('感谢您的建议，我们会认真考虑！');
          feedbackContent.value = ''; 
        } else {
          ElMessage.error("提交失败，请稍后再试");
        }
      } catch (e) {
        console.error("提交建议失败:", e);
        ElMessage.error("网络异常，提交失败");
      } finally {
        feedbackLoading.value = false;
      }
    };
    // 注销账号处理
    const deleteAccount = async () => {
      // 再次确认，防止误操作
      ElMessageBox.confirm(
        '您确定要永久注销账号吗？此操作不可撤销，所有数据将被删除。',
        '最终确认',
        {
          confirmButtonText: '是的，注销',
          cancelButtonText: '取消',
          type: 'error',
          center: true
        }
      ).then(async () => {
        deleteLoading.value = true;
        try {
          // 发送密码到服务器验证
          const resp = await fetch(BASE_URL, {
            method: 'POST',
            headers: {
              "type": "deleteAccount",
              "Content-Type": "application/json"
            },
            body: JSON.stringify({
              password: confirmPassword.value  // 密码用于验证
            }),
            credentials: 'include'
          });
          
          const data = await resp.json();
          if (resp.status === 200 && data["status"] === true) {
            ElMessage.success('账号注销成功');
            Constant.userInfo.email=''
            Constant.userInfo.userID=''

            // 跳转到登录页
            setTimeout(() => {
              router.push('/login');
            }, 1500);
          }else {
            ElMessage.error("注销失败：" + (data["msg"] || "服务器错误"));
            deleteLoading.value = false;
            showDeleteConfirm.value = false;
            confirmPassword.value = '';
          }
        } catch (e) {
          console.error("注销账号失败:", e);
          ElMessage.error("网络异常，注销失败");
          deleteLoading.value = false;
          showDeleteConfirm.value = false;
          confirmPassword.value = '';
        }
      }).catch(() => {
        deleteLoading.value = false;
      });
    };
    
    const LoadUserInfo=async ()=>{
        try{
            const resp=await fetch(BASE_URL,{
            method:"GET",
            headers:{
                "type":"UserHome"
            },
            credentials:'include'
            })
            const data=await resp.json()
            console.log(data)
            if(resp.status===200&&data["status"]==true){
                Constant.userInfo.userID=data["userID"]
                Constant.userInfo.email=data["email"]
                Constant.userInfo.vipStatus=data["vip"]
                Constant.userInfo.avatar=BASE_URL+data["avatar"]
                Constant.userInfo.registDate=data["regist_date"]
                if(Constant.userInfo.vipStatus){
                    Constant.userInfo.vip_start_time=data["vip_begin_date"]
                    Constant.userInfo.vip_end_time=data["vip_end_date"]
                }else{
                    Constant.userInfo.vip_start_time="--------"
                    Constant.userInfo.vip_end_time="--------"
                }
            }else{
                ElMessage.error("网络异常")
            }
        }catch(e){
            console.log(e)
            ElMessage.error("网络异常")
        }
    }
    
    onMounted(()=>{
        LoadUserInfo()
    })
    
    return {
      tempNickname,
      editNicknameDialog,
      vipDialog,
      selectedPlan,
      fileInput,
      membershipPlans,
      feedbackContent,
      feedbackLoading,
      showDeleteConfirm,
      confirmPassword,  
      deleteLoading,
      Constant,
      triggerFileInput,
      changeAvatar,
      saveNickname,
      upgradeMembership,
      confirmMembership,
      submitFeedback,
      deleteAccount,
    };
  }
};
</script>

<style scoped>
/* 原有样式保持不变 */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  background: linear-gradient(135deg, #667eea, #764ba2);
  min-height: 100vh;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  color: #333;
  padding: 20px;
}

.profile-container {
  max-width: 800px;
  margin: 40px auto;
}

.profile-card {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  border-radius: 20px;
  box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
  overflow: hidden;
  padding: 40px;
  position: relative;
  border: 1px solid rgba(255, 255, 255, 0.3);
}

/* 头像和基本信息区域 */
.profile-header {
  display: flex;
  align-items: center;
  padding-bottom: 30px;
  border-bottom: 1px solid rgba(102, 126, 234, 0.1);
  margin-bottom: 30px;
}

.avatar-container {
  position: relative;
  width: 140px;
  height: 140px;
  margin-right: 30px;
  cursor: pointer;
}

.avatar {
  width: 100%;
  height: 100%;
  border-radius: 50%;
  object-fit: cover;
  border: 5px solid #e0e7ff;
  transition: all 0.3s ease;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.avatar-container:hover .avatar {
  transform: scale(1.05);
  border-color: #a5b4fc;
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
}

.edit-overlay {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: rgba(0, 0, 0, 0.5);
  color: white;
  text-align: center;
  padding: 8px;
  font-size: 14px;
  border-radius: 0 0 50% 50%;
  opacity: 0;
  transition: opacity 0.3s ease;
}

.avatar-container:hover .edit-overlay {
  opacity: 1;
}

.user-info {
  flex: 1;
}

.nickname {
  display: flex;
  align-items: center;
  gap: 15px;
  margin-bottom: 20px;
}

.nickname h2 {
  font-size: 28px;
  color: #2c3e50;
  font-weight: 600;
  margin: 0;
}

.edit-btn {
  background: #6366f1;
  color: white;
  border: none;
  border-radius: 50%;
  width: 36px;
  height: 36px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 4px 10px rgba(99, 102, 241, 0.3);
}

.edit-btn:hover {
  background: #4f46e5;
  transform: rotate(15deg);
  box-shadow: 0 6px 15px rgba(99, 102, 241, 0.4);
}

.basic-info {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.info-item {
  display: flex;
  align-items: center;
  font-size: 16px;
}

.info-label {
  color: #6b7280;
  min-width: 100px;
}

.info-content {
  color: #1f2937;
  font-weight: 500;
}

.membership-badge {
  background: linear-gradient(45deg, #8b5cf6, #ec4899);
  color: white;
  padding: 6px 15px;
  border-radius: 20px;
  font-size: 14px;
  font-weight: 600;
  display: inline-block;
}

/* 会员详情区域 */
.membership-section {
  background: rgba(102, 126, 234, 0.05);
  border-radius: 16px;
  padding: 25px;
  margin-bottom: 30px;
}

/* 建议反馈区域 */
.feedback-section {
  background: rgba(102, 126, 234, 0.05);
  border-radius: 16px;
  padding: 25px;
  margin-bottom: 30px;
}

/* 账号管理区域 */
.account-management {
  background: rgba(102, 126, 234, 0.05);
  border-radius: 16px;
  padding: 25px;
}

.section-header {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 20px;
  color: #4f46e5;
  font-size: 18px;
  font-weight: 600;
}

.membership-details {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.detail-item {
  display: flex;
  justify-content: space-between;
  padding: 8px 0;
  border-bottom: 1px solid rgba(102, 126, 234, 0.1);
}

.detail-label {
  color: #6b7280;
}

.detail-value {
  color: #1f2937;
  font-weight: 500;
}

.upgrade-btn, .submit-feedback-btn {
  background: linear-gradient(45deg, #f59e0b, #ef4444);
  color: white;
  border: none;
  border-radius: 12px;
  padding: 12px 25px;
  cursor: pointer;
  font-weight: 600;
  margin-top: 10px;
  transition: all 0.3s ease;
  display: block;
  width: 100%;
  font-size: 16px;
  box-shadow: 0 4px 15px rgba(245, 158, 11, 0.3);
}

.upgrade-btn:hover, .submit-feedback-btn:hover {
  transform: translateY(-3px);
  box-shadow: 0 6px 20px rgba(245, 158, 11, 0.4);
}

.submit-feedback-btn:disabled {
  background: #ccc;
  cursor: not-allowed;
  transform: none;
  box-shadow: none;
}

/* 注销账号按钮 */
.delete-account-btn {
  background: #ef4444;
  color: white;
  border: none;
  border-radius: 12px;
  padding: 12px 25px;
  cursor: pointer;
  font-weight: 600;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 16px;
  box-shadow: 0 4px 15px rgba(239, 68, 68, 0.2);
}

.delete-account-btn:hover {
  background: #dc2626;
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(239, 68, 68, 0.3);
}

.file-input {
  display: none;
}

.feedback-content {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

/* 会员套餐样式 */
.vip-plans {
  display: flex;
  gap: 15px;
  overflow-x: auto;
  padding-bottom: 10px;
}

.vip-plan {
  flex: 1;
  min-width: 140px;
  border: 2px solid #e2e8f0;
  border-radius: 12px;
  padding: 15px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.vip-plan.active {
  border-color: #6366f1;
  background: rgba(99, 102, 241, 0.05);
}

.vip-plan .price {
  font-size: 20px;
  font-weight: 700;
  color: #4f46e5;
  margin: 10px 0;
}

.vip-plan .duration {
  color: #6b7280;
  font-size: 14px;
  margin-bottom: 15px;
}

.vip-plan .features {
  padding-left: 20px;
}

.vip-plan .features li {
  font-size: 13px;
  margin-bottom: 5px;
  color: #4b5563;
}

/* 注销确认对话框样式 */
.delete-confirm-content {
  display: flex;
  gap: 15px;
  margin-bottom: 20px;
}

.warning-icon {
  color: #f59e0b;
  font-size: 24px;
  margin-top: 3px;
}

.warning-text p {
  margin-bottom: 10px;
  line-height: 1.6;
}

.danger-note {
  color: #dc2626;
  font-weight: 500;
}

.confirm-input {
  margin-top: 15px;
}

@media (max-width: 768px) {
  .profile-header {
    flex-direction: column;
    text-align: center;
  }
  
  .avatar-container {
    margin-right: 0;
    margin-bottom: 20px;
  }
  
  .basic-info {
    align-items: center;
  }
  
  .info-label {
    text-align: right;
  }
  
  .profile-card {
    padding: 25px;
  }
}
</style>
