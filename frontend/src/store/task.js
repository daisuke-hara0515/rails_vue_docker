import axios from 'axios';

const apiUrl = 'http://localhost:3000';

const state = {
    task:[]
};

const getters = {
    task: task => state.task
}