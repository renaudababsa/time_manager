<script setup>
import { loginUser } from './User.js';
async function connection(email, password) {
  /*api(`/api/users/?name=${name}&email=${email}`, 'GET').then((res) => {
    localStorage.setItem('id', res['data'][0]['id']);
    location.reload();
  });*/
  let result = await loginUser(email, password);
  localStorage.setItem("token", result['token']);
  location.reload();
}
</script>
<template>
  <div class="row">
    <div class="offset-xl-3 col-xl-6 col-lg-12" style="padding-top: 10%; padding-bottom: 25%;">
      <div class="card shadow mb-4">
        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
          <h6 class="m-0 font-weight-bold text-primary">Login</h6>
        </div>
        <div class="card-body">
        <form @submit.prevent="connection(email, password)">
          <div class="col-xl-12">
          <input type="text" v-model="email" placeholder="email" />
          </div>
          <div class="col-xl-12">
          <input type="password" v-model="password" />
          </div>
          <div class="col-xl-12">
          <button class="btn btn-primary" type="submit">Submit</button>
          </div>
        </form>
      </div>
      </div>
    </div>
  </div>
</template>
