import axios from 'axios';

const apiUrl = 'http://localhost:3000';

const state = {
    tasks:[]
};

const getters = {
    tasks: state => state.tasks
};

const mutations = {
    setTasks: (state, tasks) => (state.tasks = tasks)
}

const actions = {
    async fetchTasks({commit}) {
        const response = await axios.get(`${apiUrl}/v1/auth/tasks`);
        commit('setTasks',response.data);
    }
}