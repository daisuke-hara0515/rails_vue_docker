<template>
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
            axios.post('http://localhost:3000/v1/auth',
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
