<template>
    <div>
        <header>
            アプリ名
            <router-link to="/login">ログイン画面に戻る</router-link>
        </header>
        <hr>
        <div>
            <div class="container">
                <label for="email">Email</label>
                <br>
                <input id="email"
                    type="email"
                    v-model="email"
                >
                <br><br>
                <label for="password">パスワード</label>
                <br>
                <input id="password"
                    type="password"
                    v-model="password"
                >
                <br><br>
                <button @click="createUser">ユーザー登録</button>
            </div>
        </div>
    </div>
</template>

<script>
import axios from "axios";

export default {
    data() {
        return {
            email: '',
            password: ''
        };
    },
    methods: {
        createUser() {
            axios.post('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDUTdIZMfLPAomby_JvC3FYf8ChEugcZ10',
            {
                email: this.email,
                password: this.password
            }).then(response => {
                console.log(response);
            }).catch(error => {
                console.log(error);
            });
            this.email = "",
            this.password = ""
        }
    }
}
</script>

<style scoped>
.container{
    width:400px;
    height:300px;
    position: absolute;
    top:250px;
    right: 400px;
}
</style>