<script setup>
import { createUser } from './User.js';
async function register(name, email, password) {
  await createUser(name, password, email);
  location.reload();
}
</script>
<template>
  <div class="row">
    <div class="offset-xl-3 col-xl-6 col-lg-12" style="padding-top: 3%;">
      <div class="card shadow mb-4">
        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
          <h6 class="m-0 font-weight-bold text-primary">Register</h6>
        </div>
        <div class="card-body">
        <form @submit.prevent="register(name, email, password)">
          <div class="col-xl-12">
          <input type="text" v-model="name" placeholder="name" />
          </div>
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
