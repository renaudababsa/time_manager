<script setup>
import WorkingTimes from './WorkingTimes.vue'
import ClockHistory from './ClockHistory.vue'
import EmployeeTable from './EmployeeTable.vue'
import TeamLeaderTable from './TeamLeaderTable.vue'
import ManagerTable from './ManagerTable.vue'
</script>

<template>
    <div class="container-fluid">
        <div class="grid">
        <div class="row">
        <!-- <WorkingTimes/>  -->
        <!-- <div v-for="team in data"> -->
        <div class="col-6"><EmployeeTable :id="id"/></div>
        <div v-if="level >= 1" class="col-6"><TeamLeaderTable :id="id"/></div>
        <div v-if="level >= 3" class="col-6"><ManagerTable :id="id"/></div>
        <div class="col-3"><ClockHistory /></div>
        <!-- </div> -->
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
        level: localStorage.getItem('level'),
        id: localStorage.getItem('id')
    };
    },
    methods: {
    async reload () {
      this.roles = await getGroups();
      this.teams = await getTeams();
      this.renderdata = await getUsers();
    },
    },
    mounted: async function() {
      this.id = localStorage.getItem('id');
    },
};
</script> 
