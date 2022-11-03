import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import "bootstrap/dist/css/bootstrap.min.css"
import "bootstrap"
import '@fortawesome/fontawesome-free/css/all.css'
import '@fortawesome/fontawesome-free/js/all.js'
import "./assets/sb-admin-2.css"
let app = createApp(App)
router.beforeEach((to, from, next) => {
    let isAuth = true;
    if (to.name !== 'login' && !isAuth) next({name:'login'})
    else next();
})
app.use(router).mount('#app')
