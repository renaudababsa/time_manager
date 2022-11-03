import { createWebHistory, createRouter } from 'vue-router';
import Home from './components/Dashboard.vue';
import Connexion from './components/Connection.vue';

const routes = [
	{
		path: '/',
		name: 'Home',
		component: Home,
	},
    {
		path: '/login',
		name: 'login',
		component: Connexion,
	},
];

const router = createRouter({
	history: createWebHistory(),
	routes,
});

export default router;