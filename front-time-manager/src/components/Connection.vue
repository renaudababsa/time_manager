<script setup>
import { loginUser } from './User.js';
import { getGroup } from './Group.js';
import Register from './Register.vue';
async function connection(email, password) {
  /*api(`/api/users/?name=${name}&email=${email}`, 'GET').then((res) => {
    localStorage.setItem('id', res['data'][0]['id']);
    location.reload();
  });*/
  let result = await loginUser(email, password);
  localStorage.setItem("id", result['data']['id']);
  localStorage.setItem("username", result['data']['username']);
  localStorage.setItem("token", result['token']);
  let role = await getGroup(result['data']['group_id']); 
  localStorage.setItem("level", role['data']['level'])
  location.reload();
}
</script>
<template>
  <div class="row">
    <div class="offset-xl-3 col-xl-6 col-lg-12" style="padding-top: 3%;">
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
  <Register />
</template>
