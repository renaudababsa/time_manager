import { createApp } from 'vue'
import App from './App.vue'
import {   LayoutPlugin, 
    ModalPlugin,
    BVModalPlugin,
    BNavbar,
    BNavbarNav,
    BNavItem,
    BNavbarBrand,
    BNavbarToggle,
    BNavForm,
    BCollapse,
    BForm,
    BAlert,
    BModal,
    BButton,
    BProgress,
    BVToastPlugin } from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

const app = createApp(App)
//app.use(BootstrapVue)
//app.use(IconsPlugin)
app.mount('#app')
