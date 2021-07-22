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
            <br><br>
            <router-link to="/register">新規ユーザー登録はこちらから</router-link>
            <br><br>
            <router-link to="/">パスワードを忘れてしまったら</router-link>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            email:"",
            password:""
        };
    },
    // データの追跡をしやすくするために、methodsのlogin関数をindex.jsに移設する
    methods: {
        login() {
            this.$store.dispatch('login',{
                email: this.email,
                password: this.password
            })
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