<template>
    <div>
        <h3>管理画面</h3>
        <br>
        <div>
        <label for="name">タスク名</label>
        <br>
        <input id="task" type="task" v-model="task">
        <p>taks is {{task}}</p>

        </div>
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