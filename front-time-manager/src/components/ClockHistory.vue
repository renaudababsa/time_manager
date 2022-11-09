<script setup>
  import { getClocks } from './Clock.js';
</script>

<template>
      <div class="card border-left-warning shadow mb-4">
        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
          <h6 class="m-0 font-weight-bold text-warning">Historique des passages</h6>
        </div>
        <div class="card-body">
        <div class="table-responsive">
          <table  class="table table-bordered" id="dataTable" width="100%" cellspacing="5">
            <thead>
              <tr>
                <th style="width:30%;">Etat</th>
                <th>Date</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="entry in renderdata['data']">
                <td class="status" v-if="entry.status" style="background-color: #53B57E;"><i class="fa fa-lg fa-sign-in" style="color:black;"></i> <b>Entrée</b></td>
                <td class="status" v-else style="background-color: #F24E1E;"><i class="fa fa-lg fa-sign-out" style="color:black;"></i> <b>Sortie</b></td>
                <td>{{entry.time}}</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
      </div>
</template>

<script>
export default {
name: 'ClockHistory',

    data() {
    return {
        renderdata: {},
    };
    },
    methods: {
    },
    mounted: async function() {
      this.renderdata = await getClocks(localStorage.getItem('id'));
      this.renderdata['data'].forEach(function(item){
        let date = new Date(item.time);
        item.time = date.getDay() + '/' + date.getMonth() + '/' + date.getFullYear() + ' ' + date.getHours() + ":" + date.getMinutes();
      });
    },
};
</script> 

<style>
.status {
  color: white;
}
</style>