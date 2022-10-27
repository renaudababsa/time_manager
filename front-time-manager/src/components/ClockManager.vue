<script setup>
import { clock } from './clockmanagerController';
async function render() {
  await clock(localStorage.getItem('id')).then((res) => {
    return res.data;
  });
}
</script>

<template>
  <div>
    <button id="clock" v-on:click="">pointer</button>
    {{ render() }}
  </div>
</template>

<style scoped>
button {
  cursor: pointer;
  padding: 8px;
  border-radius: 3px;
  color: whitesmoke;
  background-color: grey;
  font-size: 1.2em;
}
button:hover {
  background-color: darkgray;
}
</style>
