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
        login({ commit,dispatch },authData) {
            axios.post('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDUTdIZMfLPAomby_JvC3FYf8ChEugcZ10',
            {
                email:authData.email,
                password:authData.password,
                returnSecureToken: true
            }).then(response => {
                commit('updateIdToken',response.data.idToken)
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
                        // localStorageにidTokenを渡すためのコード
                        localStorage.setItem('idToken', response.data.idToken);
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