import { createWebHistory, createRouter } from 'vue-router';
import Home from './components/Dashboard.vue';
import Connexion from './components/Connection.vue';
import Register from './components/Register.vue';

const routes = [
	{
		path: '/',
		name: 'home',
		component: Home,
	},
    {
		path: '/login',
		name: 'login',
		component: Connexion,
	},
    {
		path: '/register',
		name: 'register',
		component: Register,
	},
];

const router = createRouter({
	history: createWebHistory(),
	routes,
});

export default router;