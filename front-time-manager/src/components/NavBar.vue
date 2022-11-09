<script setup>
    import { getUser } from './User.js';
</script>

<template>
    <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <router-link to="/profile">
                <a class="nav-link">
                    <span v-if="isLogged" class="mr-2 d-none d-lg-inline text-gray-600 small"><i class="fa fa-cogs"></i> Paramètres</span>
                </a>
                </router-link>
            </li>
            <li class="nav-item">
                <router-link to="#">
                <a class="nav-link">
                    <span v-if="isLogged" v-on:click="logOut" class="mr-2 d-none d-lg-inline text-gray-600 small"><i class="fa fa-sign-out"></i> Deconnexion</span>
                </a>
                </router-link>
            </li>
            <div class="topbar-divider d-none d-sm-block"></div>
            <li class="nav-item dropdown no-arrow">
                <a class="nav-link" id="userDropdown" aria-haspopup="true" aria-expanded="false">
                    <span class="mr-2 d-none d-lg-inline text-gray-600 small">{{username}}</span>
                </a>
                <!-- Dropdown - User Information -->
            </li>
        </ul>
    </nav>
</template>

<script>
export default {
  name: 'TopBar',
  
      data() {
      return {
        isLogged: 0,
          username: "(disconnected)"
      };
      },
      methods: {
        logOut () {
            localStorage.removeItem("id");
            localStorage.removeItem("username");
            localStorage.removeItem("token");
            localStorage.removeItem("level")
            location.reload();
        },
        },
      mounted: async function() {
        if (localStorage.getItem('id') == null)
            return;
        if (localStorage.getItem('token') != null)
            this.isLogged = 1;
        let res = await getUser(localStorage.getItem('id'));
        this.username = res['data']['username'];
      },
  };
  </script>
