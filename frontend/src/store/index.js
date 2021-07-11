import Vue from 'vue';
import Vuex from 'vuex';
import axios from "axios";
import router from '../router'

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
        login({ commit },authData) {
            axios.post('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDUTdIZMfLPAomby_JvC3FYf8ChEugcZ10',
            {
                email:authData.email,
                password:authData.password,
                returnSecureToken: true
            }).then(response => {
                commit('updateIdToken',response.data.idToken)
                router.push('/')
                console.log(response);
            }).catch(error => {
                console.log(error);
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