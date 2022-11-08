<template>
          <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

<!-- Sidebar - Brand -->
<a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.html">
    <div class="sidebar-brand-icon rotate-n-15"></div>
    <div class="sidebar-brand-text mx-3">TIME MANAGER</div>
</a>

<!-- Divider -->
<hr class="sidebar-divider my-0">

<!-- Nav Item - Dashboard -->
<li class="nav-item active">
    <router-link to="/">
        <a class="nav-link" aria-expanded="true" aria-controls="">
        <i class="fas fa-fw fa-tachometer-alt"></i>
        <span>Dashboard</span></a></router-link>
</li>

<hr class="sidebar-divider">

<li v-if="level == 3" class="nav-item">
    <router-link to="/teams">
    <a class="nav-link"
        aria-expanded="true" aria-controls="">
        <span>Équipes</span>
    </a></router-link>
</li>

<li v-if="level == 3" class="nav-item">
    <router-link to="/employees">
    <a class="nav-link"
        aria-expanded="true" aria-controls="">
        <span>Employés</span>
    </a></router-link>
</li>

<hr class="sidebar-divider">

</ul>
</template>

<script>
export default {
  name: 'TopBar',
  
      data() {
      return {
        level: 0
      };
      },
      mounted: async function() {
        if (localStorage.getItem('level') != null)
            this.level = localStorage.getItem('level');
      },
  };
  </script>