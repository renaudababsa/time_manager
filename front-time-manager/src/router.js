import { createWebHistory, createRouter } from 'vue-router';
import Home from './components/Dashboard.vue';
import Connexion from './components/Connection.vue';
import Register from './components/Register.vue';

const routes = [
	{
		path: '/',
		name: 'home',
		component: Home,
		meta: {level: 1},
	},
    {
		path: '/login',
		name: 'login',
		component: Connexion,
		meta: {level: 0},
	},
    {
		path: '/register',
		name: 'register',
		component: Register,
		meta: {level: 0},
	},
];

const router = createRouter({
	history: createWebHistory(),
	routes,
});

export default router;