<template>
    <div>
        <header>
            アプリ名
        </header>
        <hr>
        <div class="container">
            <label for="username">ユーザー名:</label>
            <input id="username"
                type="username"
                v-model="username"
            >
            <br><br>
            <label for="password">パスワード:</label>
            <input id="password"
                type="password"
                v-model="password"
            >
                
            <h3>
                新規ユーザーはこちらから
            </h3>
            <h3>
                パスワードを忘れてしまったら
            </h3>

        </div>
    </div>
</template>

<style scoped>
.container{
    width:400px;
    height:300px;
    position: absolute;
    top:100px;
    right: 0px;
}
</style>