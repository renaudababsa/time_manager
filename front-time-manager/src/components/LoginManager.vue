<script setup>
import HelloWorld from './HelloWorld.vue';
import TheWelcome from './TheWelcome.vue';
import Connection from './Connection.vue';
import ClockManager from './ClockManager.vue';
import WorkingTimes from './WorkingTimes.vue'
import LoginManager from './LoginManager.vue'
</script>

<template>
  <div v-if="isLogged">
    <suspense>
    <WorkingTimes/>
    </suspense>
  </div>
  <div v-else>
    <Connection />
  </div>
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