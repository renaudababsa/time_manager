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
        <form @submit.prevent="update_range(start_date, end_date)">
        <input type="datetime-local" v-model="start_date"/>
        <input type="datetime-local" v-model="end_date"/>
        <button type="submit">Submit</button>
        </form>

    <table>
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

<style>
table {
  border: 2px solid #42b983;
  border-radius: 3px;
  background-color: #fff;
}

th {
  background-color: #42b983;
  color: rgba(255, 255, 255, 0.66);
  cursor: pointer;
  user-select: none;
}

td {
  background-color: #f9f9f9;
}

th,
td {
  min-width: 120px;
  padding: 10px 20px;
}

th.active {
  color: #fff;
}

th.active .arrow {
  opacity: 1;
}

.arrow {
  display: inline-block;
  vertical-align: middle;
  width: 0;
  height: 0;
  margin-left: 5px;
  opacity: 0.66;
}

.arrow.asc {
  border-left: 4px solid transparent;
  border-right: 4px solid transparent;
  border-bottom: 4px solid #fff;
}

.arrow.dsc {
  border-left: 4px solid transparent;
  border-right: 4px solid transparent;
  border-top: 4px solid #fff;
}
</style>