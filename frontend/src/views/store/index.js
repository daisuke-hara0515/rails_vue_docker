import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

export default new Vuex.Store({
    state: {
        idToken: null
    },
    mutations: {
        updateIdToken(state,idToken) {
            state.idToken = idToken;
        }
    }
});