<script setup>
import HelloWorld from './HelloWorld.vue';
import TheWelcome from './TheWelcome.vue';
import Connection from './Connection.vue';
import ClockManager from './ClockManager.vue';
import WorkingTimes from './WorkingTimes.vue'
import TopBar from './NavBar.vue'
import SideBar from './SideBar.vue'
import Footer from './Footer.vue'
</script>

<template>

    <div v-if="isLogged" id="wrapper">
      <SideBar />
      <div id="content-wrapper">
        <div id="content">
          <TopBar/>
          <div class="container-fluid">
            <WorkingTimes/>
          </div>
    <!-- <LoginManager/> -->
    <!-- <TheWelcome /> -->
    <!--<suspense><ClockManager /></suspense>-->
    <!--<TimeTable/>-->
        </div>
        <Footer />
      </div>
    </div>
    <div v-else id="wrapper">
      <div id="content-wrapper">
        <div id="content">
          <Connection />
        </div>
        <Footer />
      </div>
    </div>

  <!--<div v-if="isLogged">
    <suspense>
    <WorkingTimes/>
    </suspense>
  </div>
  <div v-else>
    <Connection />
  </div> -->
</template>

<script>
export default {
  name: 'Login',
  
      data() {
      return {
          isLogged: false
      };
      },
      methods: {
      checkLogin () {
        if (localStorage.getItem('id'))
          this.isLogged = true;
        else
          this.isLogged = false;
      },
      },
      mounted: function() {
          this.checkLogin();
      },
  };
  </script>