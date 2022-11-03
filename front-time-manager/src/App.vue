<script setup>
import HelloWorld from './components/HelloWorld.vue';
import TheWelcome from './components/TheWelcome.vue';
import Connection from './components/Connection.vue';
import ClockManager from './components/ClockManager.vue';
import WorkingTimes from './components/WorkingTimes.vue'
import LoginManager from './components/LoginManager.vue'
import SideBar from './components/SideBar.vue'
import TopBar from './components/NavBar.vue'
</script>

<template>
          
  <!-- <header>
    <img
      alt="Vue logo"
      class="logo"
      src="./assets/logo.svg"
      width="125"
      height="125"
    />

    <div class="wrapper">
      <HelloWorld msg="You did it!" />
    </div>
  </header> -->

  <main>
    <LoginManager/>
    <!-- <LoginManager/> -->
    <!-- <TheWelcome /> -->
    <!--<suspense><ClockManager /></suspense>-->
    <!--<TimeTable/>-->
  </main>
</template>
