<script setup>
    import { createUser, updateUser, getUser, deleteUser } from './User.js';
    import { api } from '../services/api';
    async function getWorkingTimes(userId, start_date, end_date) {
        let result;
        await api('/api/workingtimes/' + userId.toString() + '?start=' + start_date + '&end=' + end_date, 'GET').then((res) => {
            result = res;
        });
        return (result);
    }
    function computeElapsedTime(startDate, endDate) {
        const date = new Date(startDate);
        const date2 = new Date(endDate);

        const test = date.getTime() / 1000;
        const test2 = date2.getTime() / 1000;

        let rest = test2 - test;
        if (rest < 0)
            rest = 0;
        let hours = Math.floor(rest/3600);
        rest = rest - (hours * 3600);
        let minutes = Math.floor(rest/60);

        return (hours + "h " + minutes + "m");
    }
</script>

<template>
    <div class="row">
      <div class="col-xl-4 col-lg-12">
          <div class="card shadow mb-4">
            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
              <h6 class="m-0 font-weight-bold text-primary">Working Times list</h6>
            </div>
          <div class="card-body">
                <form @submit.prevent="update_range(start_date, end_date)">
                <input type="datetime-local" v-model="start_date"/>
                <input type="datetime-local" v-model="end_date"/>
                <button type="submit">Submit</button>
                </form>

            <table class="table table-bordered">
            <thead>
                <tr>
                    <th>User id</th>
                    <th>Start time</th>
                    <th>End time</th>
                    <th>Time worked</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="entry in rendercode['data']">
                    <td>{{entry.user}}</td>
                    <td>{{entry.start}}</td>
                    <td>{{entry.end}}</td>
                    <td>{{computeElapsedTime(entry.start, entry.end)}}</td>
                </tr>
            </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
</template>

<script>
export default {
name: 'Create',

    data() {
    return {
        start_date: '2022-10-01 08:00:00',
        end_date: '2022-10-10 20:00:00',
        rendercode: {},
    };
    },
    methods: {
    update_range (startdate, enddate) {
        api('/api/workingtimes/' + localStorage.getItem('id') + '?start=' + startdate + '&end=' + enddate, 'GET').then((res) => {
            this.rendercode = res;
        });
    },
    },
    mounted: function() {
        this.update_range(this.start_date, this.end_date)
    },
};
</script>
