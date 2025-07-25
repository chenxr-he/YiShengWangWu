//import { Avatar } from '@element-plus/icons-vue/dist/types';
import { reactive } from 'vue';
export const userInfo = reactive({
  userID: '',
  email: '',
  registDate:'',
  avatar:'',
  vipStatus: false,
  vip_start_time:'',
  vip_end_time:'',

});

export const SingleFileMaxSize=7;//7mb