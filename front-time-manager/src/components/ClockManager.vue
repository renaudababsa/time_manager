<script setup>
import { render } from 'vue';
import { clock } from './clockmanagerController';
function log(data) {
  console.log(data);
}
</script>

<template>
  <div>
    <button id="clock" v-on:click="renderinge()">pointer</button>
    {{
      this.rendercode?.status
        ? 'terminer votre journée?'
        : 'Commencer votre journée?'
    }}
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

<script>
export default {
  name: 'Create',

  data() {
    return {
      rendercode: {},
    };
  },
  methods: {
    renderinge() {
      clock(localStorage.getItem('id')).then((res) => {
        console.log(res.data.pop());
        this.rendercode = res.data.pop();
      });
    },
    pointFetch() {},
  },
  mounted: function () {
    this.renderinge();
  },
};
</script>
