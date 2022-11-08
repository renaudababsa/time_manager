<script setup>
    import {  getUsers, getUsersByTeam } from './User.js';
    import {  getGroups } from './Group.js';
    import {  getTeams, createTeam, updateTeam, deleteTeam } from './Team.js';
</script>

<template>
    <div class="row">
      <div class="col-xl-6 col-lg-12">
        <div class="card shadow mb-4">
          <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Nouvelle équipe</h6>
          </div>
          <div class="card-body">
            <form @submit.prevent="newTeam(name)">
              <div class="form-group">
                <label>Nom de l'équipe</label>
                <input type="text" class="form-control" v-model="name">
              </div>
              <div class="offset-xl-5 offset-lg-5 col-xl-6 col-lg-6">
                <button class="btn btn-lg btn-primary" type="submit"><i class="fa fa-plus"></i> Créer</button>
              </div>
            </form>
          </div>
        </div>
      </div>
      <div class="col-xl-12 col-lg-12">
        <div class="card shadow mb-4">
          <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Liste des equipes</h6>
          </div>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                  <tr>
                    <th>Equipe <i class="fa fa-pen"></i></th>
                    <th>Nombres</th>
                    <th>Action</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="entry in renderdata['data']">
                    <td><input type="text" class="editable" v-model="entry.name" @change="changeTeam(entry.id, entry.name)"></td>
                    <td>{{entry.count}}</td>
                    <td><button class="btn btn-danger" v-on:click="removeTeam(entry.id)"><i class="fa fa-trash"></i></button></td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
</template>

<style>
td .editable {
  background:transparent;
  border:none;
  width:100%;
  height:100%;
  color:#858796;
}
</style>

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
    async reload () {
      this.renderdata = await getTeams();
      this.renderdata['data'].forEach(async function(item){
        let tmp = await getUsersByTeam(item.id);
        item["count"] = tmp['data'].length;
      });
    },
    async newTeam (name) {
      await createTeam(name);
      this.reload();
    },
    async changeTeam(id, name) {
      await updateTeam(id, name);
      this.reload();
    },
    async removeTeam(id) {
      await deleteTeam(id);
      this.reload();
    }
    },
    mounted: async function() {
      await this.reload();
    },
};
</script>