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

<li class="nav-item">
    <router-link to="/login">
    <a class="nav-link"
        aria-expanded="true" aria-controls="">
        <span>Équipes</span>
    </a></router-link>
</li>

<li class="nav-item">
    <router-link to="/">
    <a class="nav-link"
        aria-expanded="true" aria-controls="">
        <span>Employés</span>
    </a></router-link>
</li>

<hr class="sidebar-divider">

</ul>
</template>
