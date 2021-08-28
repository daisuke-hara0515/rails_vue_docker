<template>
    <div>
        <h3>管理画面</h3>
        <br>
        <label for="title">タイトル</label>
        <br>
        <input 
            id="title"
            type="text"
            v-model="title"
        >
        <p>{{ title }}</p>

        <span class="header-item" @click="logout">ログアウト</span>
    </div>
</template>

<script>
export default {
    data() {
        return {
            title: "",
        };
    }
}
</script>

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