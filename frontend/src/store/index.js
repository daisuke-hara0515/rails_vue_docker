import Vue from 'vue';
import Vuex from 'vuex';
import axios from "axios";
import router from '../router';

Vue.use(Vuex);

export default new Vuex.Store({
    state: {
        idToken: null
    },
    getters: {
        idToken: state => state.idToken
    },
    mutations: {
        updateIdToken(state,idToken) {
            state.idToken = idToken;
        }
    },
    actions: {
        // ログイン時に実行されるようにする関数(autoLogin)
        autoLogin({ commit, dispatch }) {
            const idToken = localStorage.getItem('idToken');
            // idTokenが無かったらそのまま何もしない
            if (!idToken) return;
            // autoLogin実行時、localStorageにあるexpiryTimeMsを取り出して、トークンが有効期限内なのかどうか調べる
            const now = new Date();
            const expiryTimeMs = localStorage.getItem('expiryTimeMs');
            // 有効期限をboolean型で判定する。
            const isExpired = now.getTime() >= expiryTimeMs;
            if (isExpired) {
                dispatch('refreshIdToken');
            }
            // idTokenがあったらupdateIdToken関数を実行する
            commit('updateIdToken',idToken);
        },
        login({ commit,dispatch },authData) {
            axios.post('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDUTdIZMfLPAomby_JvC3FYf8ChEugcZ10',
            {
                email:authData.email,
                password:authData.password,
                returnSecureToken: true
            }).then(response => {
                // 現在の時刻をnowという変数で定義する
                const now = new Date();
                // 有効期限を定義する。now.getTime()で1970/01/01から現在までの経過時間を取得し、それに有効期限の時刻を足す
                const expiryTimeMs = now.getTime() + response.data.expiresIn * 1000;
                commit('updateIdToken',response.data.idToken);
                // localStorageにidTokenを渡すためのコード
                localStorage.setItem('idToken', response.data.idToken);
                // localStorageに有効期限を残しておく
                localStorage.setItem('expiryTimeMs', expiryTimeMs);
                // localStorageにリクエストで返ってきた更新トークンを保存する
                localStorage.setItem('refreshToken',response.data.refreshToken);
                // setTimeoutでトークンをリフレッシュするコード
                setTimeout(() => {
                    dispatch('refreshIdToken',response.data.refreshToken);
                }, response.data.expiresIn * 1000)
                router.push('/');
            });
        },
        refreshIdToken({ commit, dispatch }, refreshToken){
            axios.post('https://securetoken.googleapis.com/v1/token?key=AIzaSyDUTdIZMfLPAomby_JvC3FYf8ChEugcZ10'
                    , {
                        grant_type: 'refresh_token',
                        refresh_token: refreshToken
                      }
                      // 応答コード
                    ).then(response => {
                        commit("updateIdToken",response.data.idToken);
                        setTimeout(() => {
                            dispatch('refreshIdToken', response.data.refresh_token);
                        }, response.data.expires_in * 1000)
                    });
        },
        register({ commit },authData) {
            axios.post('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDUTdIZMfLPAomby_JvC3FYf8ChEugcZ10',
            {
                email:authData.email,
                password:authData.password,
                returnSecureToken: true
            }).then(response => {
                commit('updateIdToken',response.data.idToken)
                console.log(response);
            }).catch(error => {
                console.log(error);
            });
        }
    }
});