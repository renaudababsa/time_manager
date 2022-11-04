<script setup>
    import { getUser } from './User.js';
</script>

<template>
    <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
        <ul class="navbar-nav ml-auto">
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
          username: "(disconnected)"
      };
      },
      mounted: async function() {
        if (localStorage.getItem('id') == null)
            return;
        let res = await getUser(localStorage.getItem('id'));
        this.username = res['data']['username'];
      },
  };
  </script>
