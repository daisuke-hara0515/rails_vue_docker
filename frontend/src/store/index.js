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
        async autoLogin({ commit, dispatch }) {
            const idToken = localStorage.getItem('idToken');
            // idTokenが無かったらそのまま何もしない
            if (!idToken) return;
            // autoLogin実行時、localStorageにあるexpiryTimeMsを取り出して、トークンが有効期限内なのかどうか調べる
            const now = new Date();
            const expiryTimeMs = localStorage.getItem('expiryTimeMs');
            // 有効期限をboolean型で判定する。
            const isExpired = now.getTime() >= expiryTimeMs;
            const refreshToken = localStorage.getItem('refreshToken');
            if (isExpired) {
                // refreshTokenを引数として、refreshIdToken関数を実行する
                await dispatch('refreshIdToken',refreshToken);
            } else {
                // 有効期限から現在の時刻を差し引いて、あと何分後に有効期限がくるのかを定義する
                const expiresInMs = expiryTimeMs - now.getTime();
                setTimeout(() => {
                    dispatch('refreshIdToken', refreshToken);
                }, expiresInMs);
                commit('updateIdToken', idToken);
            }
            // idTokenがあったらupdateIdToken関数を実行する
            commit('updateIdToken',idToken);
        },
        login({ dispatch },authData) {
            axios.post('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDUTdIZMfLPAomby_JvC3FYf8ChEugcZ10',
            {
                email:authData.email,
                password:authData.password,
                returnSecureToken: true
            }).then(response => {
                dispatch('setAuthData',{
                    idToken: response.data.idToken,
                    expiresIn: response.data.expiresIn,
                    refreshToken: response.data.refreshToken
                });
                router.push('/');
            });
        },
        logout({ commit }) {
            commit ('updateIdToken', null);
            localStorage.removeItem('idToken');
            localStorage.removeItem('expiryTimeMs');
            localStorage.removeItem('refreshToken');
            router.replace('/login');
        },
        async refreshIdToken({ dispatch }, refreshToken){
            await axios.post('https://securetoken.googleapis.com/v1/token?key=AIzaSyDUTdIZMfLPAomby_JvC3FYf8ChEugcZ10'
                    , {
                        grant_type: 'refresh_token',
                        refresh_token: refreshToken
                      }
                      // 応答コード
                    ).then(response => {
                        dispatch('setAuthData',{
                            idToken: response.data.id_Token,
                            expiresIn: response.data.expires_in,
                            refreshToken: response.data.refresh_token
                        });
                    });
        },
        register({ dispatch },authData) {
            axios.post('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDUTdIZMfLPAomby_JvC3FYf8ChEugcZ10',
            {
                email:authData.email,
                password:authData.password,
                returnSecureToken: true
            }).then(response => {
                dispatch('setAuthData',{
                    idToken: response.data.idToken,
                    expiresIn: response.data.expiresIn,
                    refreshToken: response.data.refreshToken
                });
                router.push('/')
            });
        },
        setAuthData({ commit, dispatch }, authData) {
            // 現在の時刻をnowという変数で定義する
            const now = new Date();
            // 有効期限を定義する。now.getTime()で1970/01/01から現在までの経過時間を取得し、それに有効期限の時刻を足す
            const expiryTimeMs = now.getTime() + authData.expiresIn * 1000;
            commit('updateIdToken',authData.idToken);
            // localStorageにidTokenを渡すためのコード
            localStorage.setItem('idToken', authData.idToken);
            // localStorageに有効期限を残しておく
            localStorage.setItem('expiryTimeMs', expiryTimeMs);
            // localStorageにリクエストで返ってきた更新トークンを保存する
            localStorage.setItem('refreshToken',authData.refreshToken);
            // setTimeoutでトークンをリフレッシュするコード
            setTimeout(() => {
                dispatch('refreshIdToken',authData.refreshToken);
            }, authData.expiresIn * 1000)
        }
    }
});