<script setup>
import { api } from '../services/api';
defineProps({
  msg: {
    type: String,
    required: true,
  },
});

//CLOCKS
// api('/api/clocks/2', 'POST', {
//   clock: {
//     time: '2022-10-06 11:11:14',
//     status: true,
//   },
// }).then((res) => {
//   console.log(res);
// });

// //USERS
// api('/api/users/1', 'GET').then((res) => {
//   console.log(res);
// });

// //WORKINGTIMES
// api(
//   '/api/workingtimes/1?start=2022-10-06 11:15:11&end=2023-10-06 11:11:11',
//   'GET'
// ).then((res) => {
//   console.log(res);
// });

// api('/api/workingtimes/1/8', 'GET').then((res) => {
//   console.log(res);
// });

// api('/api/workingtimes/8', 'GET').then((res) => {
//   console.log(res);
// });

// api('/api/workingtimes/1', 'POST', {
//   working_time: {
//     start: '2022-10-06 11:15:11',
//     end: '2023-10-06 11:11:11',
//   },
// }).then((res) => {
//   console.log(res);
// });

// api('/api/workingtimes/5', 'PATCH', {
//   working_time: {
//     start: '2022-10-06 01:15:11',
//     end: '2023-10-06 11:11:11',
//   },
// }).then((res) => {
//   console.log(res);
// });

// api('/api/workingtimes/6', 'DELETE').then((res) => {
//   console.log(res);
// });
</script>

<template>
  <div class="greetings">
    <h1 class="green">{{ msg }}</h1>
    <h3>
      You’ve successfully created a project with
      <a href="https://vitejs.dev/" target="_blank" rel="noopener">Vite</a> +
      <a href="https://vuejs.org/" target="_blank" rel="noopener">Vue 3</a>.
    </h3>
  </div>
</template>

<style scoped>
h1 {
  font-weight: 500;
  font-size: 2.6rem;
  top: -10px;
}

h3 {
  font-size: 1.2rem;
}

.greetings h1,
.greetings h3 {
  text-align: center;
}

@media (min-width: 1024px) {
  .greetings h1,
  .greetings h3 {
    text-align: left;
  }
}
</style>
