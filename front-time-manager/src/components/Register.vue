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
          <h6 class="m-0 font-weight-bold text-primary">Inscription</h6>
        </div>
        <div class="card-body">
        <form @submit.prevent="register(name, email, password)">
          <div class="form-group">
          <label>Nom d'utilisateur</label>
          <input type="text" class="form-control" v-model="name" placeholder="name" />
          </div>
          <div class="form-group">
          <label>Email</label>
          <input type="text" class="form-control" v-model="email" placeholder="email" />
          </div>
          <div class="form-group">
          <label>Mot de passe</label>
          <input type="password" class="form-control" v-model="password" />
          </div>
          <button class="btn btn-primary" type="submit">S'inscrire</button>
        </form>
      </div>
      </div>
    </div>
  </div>
</template>
