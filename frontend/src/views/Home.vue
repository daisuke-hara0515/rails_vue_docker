<template>
    <div>
        <h3>管理画面</h3>
        <label for="taskname">タスク名</label>
        <br>
        <input id="taskname" type="text" v-model="taskname">
        <p>{{taskname}}</p>
        <br>
        <span class="header-item" @click="logout">ログアウト</span>
    </div>
</template>

<script>
export default {
    data() {
        return {
            taskname: "",
        };
    },
    methods: {
        logout() {
            // store/index.jsのlogout関数を実行させるようにする
            this.$store.dispatch('logout');
        }
    }
};
</script>

<style scoped>
.header-item {
    cursor: pointer;
}
</style>
