<template>
    <div>
        <h3>管理画面</h3>
        <label for="taskName">タスク名</label>
        <br>
        <input id="taskName" type="text" v-model="taskName">
        <br>
        <label for="description">詳細</label>
        <br>
        <input id="description" type="textarea" v-model="description">
        <br>
        <br>
        <button @click="createTask">タスク作成</button>
        <br>
        <span class="header-item" @click="logout">ログアウト</span>
        <div class="registered-tasks">
            <h4>登録されているタスク</h4>
        </div>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    data() {
        return {
            taskName: "",
            description: "",
            taskList: [],
        };
    },
    created() {
        axios.get('http://localhost:3000/v1/auth/tasks')
        .then(response => {
            console.log(response);
        })
    },
    methods: {
        logout() {
            // store/index.jsのlogout関数を実行させるようにする
            this.$store.dispatch('logout');
        },
        createTask() {
            axios.post('http://localhost:3000/v1/auth/tasks',{
                task_params:
                {
                    name: this.taskName,
                    description: this.description
                }
            })
            this.taskName = ""
            this.description = ""
        }
    }
};
</script>

<style scoped>
.header-item {
    cursor: pointer;
}

.registered-tasks {
    position: relative;
    bottom: 200px;
    left: 300px;
}
</style>
