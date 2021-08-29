<template>
    <div>
        <h3>管理画面</h3>
        <label for="taskname">タスク名</label>
        <br>
        <input id="taskname" type="text" v-model="taskname">
        <br>
        <label for="description">詳細</label>
        <br>
        <input id="description" type="textarea" v-model="description">
        <br>
        <br>
        <button @click="createTask">タスク作成</button>
        <br>
        <span class="header-item" @click="logout">ログアウト</span>
    </div>
</template>

<script>
export default {
    data() {
        return {
            taskname: "",
            description: "",
        };
    },
    methods: {
        createTask() {
            this.$store.dispatch('createTask',{
                taskName: this.taskName,
                description: this.description,
            })
            this.taskName = ""
            this.description = ""
        },
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
