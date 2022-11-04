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
    let isAuth = false;
    if (localStorage.getItem("token"))
        isAuth = true;
    console.log(to.meta.level);
    if (to.name !== 'login' && to.name !== 'register' && !isAuth) {
        next({name:'login'})
    } else if (to.name == 'register' && isAuth || to.name == 'login' && isAuth) {
        next({name:'home'})
    } else {
        next();
    }
})
app.use(router).mount('#app')
