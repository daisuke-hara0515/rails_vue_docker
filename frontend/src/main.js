// main.jsがVueアプリケーション実行時に最初に読み込まれる
import Vue from 'vue';
import App from './App.vue';
import router from './router';
import store from './store';

Vue.config.productionTip = false

// autologinを実行した後に、new Vueするように非同期処理を行う
store.dispatch('autoLogin').then(() => {
  new Vue({
    router,
    store,
    render: h => h(App),
  }).$mount('#app')
});


