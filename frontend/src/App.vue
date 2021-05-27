// App.vueは一番大元のコンポーネント
<template>
  <div>
    <header>
      <router-link to="/" class="header-item">管理画面</router-link>
      <router-link to="/login" class="header-item">ログイン</router-link>
      <router-link to="/register" class="header-item">登録画面</router-link>
    </header>
    <router-view></router-view>
  </div>
</template>

<style scoped>
.header-item{
  padding: 10px;
}
</style>