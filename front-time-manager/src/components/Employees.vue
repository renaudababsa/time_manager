<script setup>
    import {  getUsers, deleteUser, updateUserRole, updateUserTeam } from './User.js';
    import {  getGroups } from './Group.js';
    import {  getTeams } from './Team.js';
</script>

<template>
  <div class="card shadow mb-4">
    <div class="card-header py-3">
      <h6 class="m-0 font-weight-bold text-primary">Employées</h6>
    </div>
    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
          <thead>
            <tr>
              <th>Nom</th>
              <th>Role <i class="fa fa-pen"></i></th>
              <th>Equipe <i class="fa fa-pen"></i></th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="entry in renderdata['data']">
              <td>{{entry.username}}</td>
              <td><select class="form-select" v-model.number="entry.group_id" @change="changeRole(entry.id, entry.group_id)">
                <option class="styleoption" v-for="role in roles['data']" :value="role.id" :select="role.id == entry.group_id">{{role.name}}</option>
              </select></td>

              <td><select class="form-select" v-model.number="entry.team_id" @change="changeTeam(entry.id, entry.team_id)">
              <option class="styleoption" v-for="team in teams['data']" :value="team.id" :select="team.id == entry.team_id">{{team.name}}</option>
              </select></td>
              <td><button class="btn btn-danger" v-on:click="removeUser(entry.id)"><i class="fa fa-trash"></i></button></td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
export default {
name: 'Employees',

    data() {
    return {
        roles: {},
        teams: {},
        renderdata: {},
    };
    },
    methods: {
    getCorrRole (id) {
        let ret = "";
        this.roles['data'].forEach(function(item){
          if (item['id'] == id) {
            ret = item['name'];
          }
        });
        return (ret);
    },
    getCorrTeam (id) {
        let ret = "";
        this.teams['data'].forEach(function(item){
          if (item['id'] == id) {
            ret = item['name'];
          }
        });
        return (ret);
    },
    async reload () {
      this.roles = await getGroups();
      this.teams = await getTeams();
      this.renderdata = await getUsers();
    },
    async removeUser(id) {
      await deleteUser(id);
      this.reload();
    },
    async changeTeam(id, team_id) {
      await updateUserTeam(id, team_id);
      this.reload();
    },
    async changeRole(id, group_id) {
      await updateUserRole(id, group_id);
      this.reload();
    },
    },
    mounted: async function() {
      await this.reload();
    },
};
</script>
