<template>
  <div class="login-page">
    <div class="login-card">
      <div class="login-brand">
        <img :src="'/favicon.svg'" alt="墨页 Logo" class="brand-icon" />
        <h1>在线文档管理系统</h1>
        <p>Document Management System · 后台管理</p>
      </div>

      <el-form ref="formRef" :model="form" :rules="rules" class="login-form" @keyup.enter="handleLogin">
        <el-form-item prop="username">
          <el-input v-model="form.username" placeholder="请输入用户名" size="large" prefix-icon="User" />
        </el-form-item>
        <el-form-item prop="password">
          <el-input v-model="form.password" type="password" placeholder="请输入密码" size="large" prefix-icon="Lock" show-password />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" size="large" class="login-btn" :loading="loading" @click="handleLogin">登 录</el-button>
        </el-form-item>
      </el-form>

      <div class="login-tip">测试账号：abo / abo</div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { login } from '@/api'

const router = useRouter()
const formRef = ref()
const loading = ref(false)
const form = reactive({ username: '', password: '' })
const rules = {
  username: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
  password: [{ required: true, message: '请输入密码', trigger: 'blur' }]
}

async function handleLogin() {
  await formRef.value.validate()
  loading.value = true
  try {
    const res = await login(form.username, form.password)
    // res.code === 0 且带 token 才是登录成功
    if (res.code === 0 && res.token) {
      localStorage.setItem('token', res.token)
      localStorage.setItem('userInfo', JSON.stringify({ username: form.username }))
      ElMessage.success('登录成功')
      router.push('/')
    } else {
      ElMessage.error(res.msg || '登录失败')
    }
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.login-page {
  min-height: 100vh; display: flex; align-items: center; justify-content: center;
  background: var(--bg-page);
}
.login-card {
  width: 400px; background: #fff; border-radius: var(--radius-l); padding: 44px 40px;
  box-shadow: var(--shadow-2); border: 1px solid var(--border-light);
}
.login-brand { text-align: center; margin-bottom: 32px; }
.brand-icon {
  width: 52px; height: 52px; margin: 0 auto 16px; display: block;
  border-radius: 12px;
}
.login-brand h1 { font-size: 21px; margin: 0 0 6px; color: var(--text-1); font-weight: 600; }
.login-brand p { font-size: 12px; color: var(--text-3); margin: 0; }
.login-btn { width: 100%; height: 42px; font-weight: 500; }
.login-tip {
  text-align: center; font-size: 12px; color: var(--text-3); margin-top: 16px;
  padding-top: 16px; border-top: 1px solid var(--border-light);
}
</style>
