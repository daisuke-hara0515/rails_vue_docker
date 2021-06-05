<template>
    <div>
        <header>
            アプリ名
        </header>
        <hr>
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
            <button @click="login">ログイン</button>
            <button>新規ユーザー登録はこちらから</button>
            <br><br>
            <button>パスワードを忘れてしまったら</button>
        </div>
    </div>
</template>

<script>
import axios from "axios";

export default {
    data() {
        return {
            email:"",
            password:""
        };
    },
    methods: {
        login() {
            axios.post('http://localhost:3000/v1/auth/sign_in',
            {
                email:this.email,
                password:this.password
            }).then(response => {
                console.log(response);
            }).catch(error => {
                console.log(error);
            });
            this.email = ""
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
    right: 100px;
}
</style>