<script setup>
    import {  getUsers } from './User.js';
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
              <th>Position</th>
              <th>Equipe</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="entry in renderdata['data']">
              <td>{{entry.username}}</td>
              <td>{{getCorrRole(entry.group_id)}}</td>
              <td>{{getCorrTeam(entry.team_id)}}</td>
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
    },
    mounted: async function() {
        this.roles = await getGroups();
        this.teams = await getTeams();
        this.renderdata = await getUsers();
    },
};
</script>