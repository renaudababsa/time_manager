<script setup>
    import {  getUsers, getUsersByTeam } from './User.js';
    import {  getGroups } from './Group.js';
    import {  getTeams } from './Team.js';
</script>

<template>
  <div class="card shadow mb-4">
    <div class="card-header py-3">
      <h6 class="m-0 font-weight-bold text-primary">Liste des equipes</h6>
    </div>
    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
          <thead>
            <tr>
              <th>Equipe</th>
              <th>Nombres</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="entry in renderdata['data']">
              <td>{{entry.name}}</td>
              <td>{{entry.count}}</td>
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
        renderdata: {},
        count: [],
    };
    },
    methods: {
    getCountUserTeam (id) {
        let ret = "";
        this.roles['data'].forEach(function(item){
          if (item['id'] == id) {
            ret = item['name'];
          }
        });
        return (ret);
    },
    },
    mounted: async function() {
        this.renderdata = await getTeams();
        this.renderdata['data'].forEach(async function(item){
          let tmp = await getUsersByTeam(item.id);
          item["count"] = tmp['data'].length;
        });
    },
};
</script>