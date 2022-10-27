<script setup>
import { api } from '../services/api';
function connection(name, email) {
  api(`/api/users/?name=${name}&email=${email}`, 'GET').then((res) => {
    localStorage.setItem('id', res.data.id);
  });
}
</script>
<template>
  <form @submit.prevent="connection(name, email)">
    <input type="text" v-model="name" placeholder="name" />
    <input type="text" v-model="email" placeholder="email" />
    <button type="submit">Submit</button>
  </form>
</template>
