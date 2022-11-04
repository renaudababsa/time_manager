import { createWebHistory, createRouter } from 'vue-router';
import Home from './components/Dashboard.vue';
import Connexion from './components/Connection.vue';
import Register from './components/Register.vue';
import Employees from './components/Employees.vue';

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
	{
		path: '/employees',
		name: 'employees',
		component: Employees,
		meta: {level: 1},
	}
];

const router = createRouter({
	history: createWebHistory(),
	routes,
});

export default router;