import { createWebHistory, createRouter } from 'vue-router';
import Home from './components/Dashboard.vue';
import Connexion from './components/Connection.vue';
import Employees from './components/Employees.vue';
import Teams from './components/Teams.vue';

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
		path: '/employees',
		name: 'employees',
		component: Employees,
		meta: {level: 1},
	},
	{
		path: '/teams',
		name: 'teams',
		component: Teams,
		meta: {level: 1},
	}
];

const router = createRouter({
	history: createWebHistory(),
	routes,
});

export default router;