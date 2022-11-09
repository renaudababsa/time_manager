<script setup>
import { getUser, updateUser } from './User.js';
import { getTeam } from './Team.js';
import { getGroup } from './Group.js';

</script>
<template>
  <div class="row">
    <div class="offset-xl-3 col-xl-6 col-lg-12" style="padding-top: 3%;">
      <div class="card shadow mb-4">
        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
          <h6 class="m-0 font-weight-bold text-primary">Mon profil</h6>
        </div>
        <div class="card-body">
        <form @submit.prevent="updateProfile(name, email, password)">
          <div class="form-group">
          <label>Nom d'utilisateur</label>
          <input type="text" class="form-control" v-model="name"/>
          </div>
          <div class="form-group">
          <label>Email</label>
          <input type="text" class="form-control" v-model="email" />
          </div>
          <div class="form-group">
          <label>Mot de passe</label>
          <input type="password" class="form-control" v-model="password" />
          </div>
          <div class="form-group">
          <label>Equipe</label>
          <input type="text" class="uneditable" v-model="team" disabled/>
          </div>
          <div class="form-group">
          <label>Role</label>
          <input type="text" class="uneditable" v-model="role" disabled/>
          </div>
          <button class="btn btn-primary btn-lg offset-xl-5" type="submit"><i class="fa fa-save"></i> Enregistrer</button>
        </form>
      </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
name: 'Profile',

    data() {
    return {
        name: "",
        email: "",
        role: "Non défini",
        team: "Non défini",
        password: ""
    };
    },
    methods: {
      async updateProfile(username, email, password) {
        await updateUser(localStorage.getItem('id'), username, email, password);
        location.reload();
      }
    },
    mounted: async function() {
        let userinfo = await getUser(localStorage.getItem('id'));
        let groupinfo;
        let roleinfo
        if (userinfo['data']['team_id']) {
          groupinfo = await getTeam(userinfo['data']['team_id']);
          this.team = groupinfo['data']['name'];
        }
        if (userinfo['data']['group_id']) {
          roleinfo = await getGroup(userinfo['data']['group_id']);
          this.role = roleinfo['data']['name'];
      }
        this.name = userinfo['data']['username'];
        this.email = userinfo['data']['email'];
    },
};
</script>

<style>
.uneditable {
  background:transparent;
  border:none;
  width:100%;
  height:100%;
  color:#858796;
}
</style>