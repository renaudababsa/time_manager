<script setup>
import WorkingTimes from './WorkingTimes.vue'
import EmployeeTable from './EmployeeTable.vue'
import TeamLeaderTable from './TeamLeaderTable.vue'
import ManagerTable from './ManagerTable.vue'
</script>

<template>
    <div class="container-fluid">
        <!-- <WorkingTimes/>  -->
        <!-- <div v-for="team in data"> -->
        <EmployeeTable id='8'/>
        <TeamLeaderTable id='5'/>
        <ManagerTable id='3'/>
        <!-- </div> -->
    </div>
</template>