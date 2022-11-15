import { createWebHistory, createRouter } from 'vue-router';
import Home from './components/Dashboard.vue';
import Connexion from './components/Connection.vue';
import Employees from './components/Employees.vue';
import Teams from './components/Teams.vue';
import Profile from './components/Profile.vue';

const routes = [
	{
		path: '/',
		name: 'home',
		component: Home,
		meta: {level: 0},
	},
    {
		path: '/login',
		name: 'login',
		component: Connexion,
		meta: {level: 0},
	},
	{
		path: '/profile',
		name: 'profile',
		component: Profile,
		meta: {level: 0},
	},
	{
		path: '/employees',
		name: 'employees',
		component: Employees,
		meta: {level: 3},
	},
	{
		path: '/teams',
		name: 'teams',
		component: Teams,
		meta: {level: 3},
	}
];

const router = createRouter({
	history: createWebHistory(),
	routes,
});

export default router;