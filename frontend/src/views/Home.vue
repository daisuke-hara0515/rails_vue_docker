<template>
    <div>
        <h3>管理画面</h3>
        <span class="header-item" @click="logout">ログアウト</span>
    </div>
</template>

<style scoped>
.header-item {
    cursor: pointer;
}
</style>

<script>
export default {
    methods: {
        logout() {
            // store/index.jsのlogout関数を実行させるようにする
            this.$store.dispatch('logout');
        }
    }
};
</script>