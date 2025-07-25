import { createRouter, createWebHistory } from 'vue-router'

// 导入页面组件
import Login from '../components/Login.vue'
import Home from '../components/Home.vue'
import Register from '../components/Register.vue'
import EditView from '../components/EditView.vue'
import ShouYe from '../components/ShouYe.vue'
import XuNiHuanYi from '../components/XuNiHuanYi.vue'
import WenShengTu from '../components/WenShengTu.vue'
import RenLianFengGeHua from '../components/RenLianFengGeHua.vue'
import RenLianXiaoXiang from '../components/RenLianXiaoXiang.vue'
import ZhiNengKouTu from '../components/ZhiNengKouTu.vue'
import LiShiJiLu from '../components/LiShiJiLu.vue'
import GeRenZhuYe from '@/components/GeRenZhuYe.vue'
import * as Constant from '@/GlobalInfo'
const routes = [
  // 根路径重定向到首页
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  // 独立的登录页面
  {
    path: '/login',
    name: 'Login',
    component: Login
  },
  // 独立的注册页面
  {
    path: '/register',
    name: 'Register',
    component: Register
  },
  {
    path: '/edit',
    name: 'EditView',
    component: EditView,
    children: [
      {
        path: 'shou-ye',
        name: 'ShouYe',
        component: ShouYe
      },
      {
        path: 'xu-ni-huan-yi',
        name: 'XuNiHuanYi',
        component: XuNiHuanYi
      },
      {
        path: 'wen-sheng-tu',
        name: 'WenShengTu',
        component: WenShengTu
      },
      {
        path: 'ren-lian-feng-ge-hua',
        name: 'RenLianFengGeHua',
        component: RenLianFengGeHua
      },
      {
        path: 'ren-lian-xiao-xiang',
        name: 'RenLianXiaoXiang',
        component: RenLianXiaoXiang
      },
      {
        path: 'zhi-neng-kou-tu',
        name: 'ZhiNengKouTu',
        component: ZhiNengKouTu
      },
      {
        path: 'li-shi-ji-lu',
        name: 'LiShiJiLu',
        component: LiShiJiLu
      },
      {
        path: 'ge-ren-zhu-ye',
        name: 'GeRenZhuYe',
        component:  GeRenZhuYe
      },
    ]
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

// 检查用户是否已登录的函数
const isAuthenticated = () => {
  const userId=Constant.userInfo.userID
  const email = Constant.userInfo.email
  return (userId && email)
}

// 路由守卫
router.beforeEach((to, _, next) => {
  const isLoggedIn = isAuthenticated()

  // 需要登录才能访问的页面
  const requiresAuth = ['/edit']

  // 已登录用户不应该访问的页面（登录、注册页面）
  const guestOnlyPages = ['/login', '/register']

  // 检查当前路由是否需要登录
  const needsAuth = requiresAuth.some(path => to.path.startsWith(path))

  // 检查当前路由是否是仅游客页面
  const isGuestOnlyPage = guestOnlyPages.includes(to.path)

  if (needsAuth && !isLoggedIn) {
    // 需要登录但未登录，重定向到登录页面
    console.log('未登录，重定向到登录页面')
    next('/login')
  } else if (isGuestOnlyPage && isLoggedIn) {
    // 已登录但访问登录/注册页面，重定向到编辑页面
    console.log('已登录，重定向到编辑页面')
    next('/edit')
  } else {
    // 其他情况正常访问
    next()
  }
})

export default router
