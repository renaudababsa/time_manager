<script>
import { get_employee_datatable } from './EmployeeTable.vue'
import { get_teamleader_datatable } from './TeamLeaderTable.vue'
import { get_manager_datatable } from './ManagerTable.vue'
import { renderChart } from './RenderChart.vue'
import { getUsersByTeam, getUser } from './User.js'
import { getTeams } from './Team.js'

export default {
  props: ['id'],
  data() {
    return {
      timetable: [],
      ChartName: '',
      interval_time: {
        start: '2022-01-01T06:00:00',
        end: '2022-01-02T20:00:00',
      },
      rendercode: {},
    }
  },
  methods: {
   async update_range(startdate, enddate) {
    this.interval_time.start = startdate
    this.interval_time.end = enddate
    // let username = localStorage.getItem('username')
    // console.log(username)
    // ----------------- Employee -----------------
    // let username = 8
    // ----------------- TeamLeader -----------------
    // let usernames_l = [8, 9, 10]
    // let teamleader = await getUser(4)
    // let users = await getUsersByTeam(teamleader['data']['team_id'])
    // console.log("USERS : ", users['data'])
    // let usernames_l = []
    // for (let user in users['data']) {
    //   usernames_l.push(users['data'][user]['id'])
    // }
    // ----------------- Manager -----------------
    let teams = await getTeams()
    // ----------------- ALGO -----------------
    this.ChartName = 'USERS'
    let elapsed_time =
      Math.abs(
        new Date(this.interval_time.end) - new Date(this.interval_time.start),
      ) /
      (3600 * 100 * 10)
    if (typeof username === 'number') {
      this.timetable = await get_employee_datatable(
        this.id,
        this.interval_time,
      )
      elapsed_time = 12
    } else if (typeof usernames_l === 'object') {
      this.timetable = await get_teamleader_datatable(
        usernames_l,
        this.interval_time,
      )
      elapsed_time = elapsed_time * (12 / 24)
    } else if (typeof teams === 'object') {
      this.timetable = await get_manager_datatable(
        teams,
        this.interval_time,
      )
    }
    // ----------------- RENDER -----------------
    renderChart(this.timetable[0], this.timetable[1], this.ChartName)
    },
  },
  async mounted() {
    this.update_range(this.interval_time.start, this.interval_time.end)
  },
}
</script>

<template>
  <div>
    <form @submit.prevent="update_range(interval_time.start, interval_time.end)">
      <input type="datetime-local" v-model="interval_time.start" />
      <input type="datetime-local" v-model="interval_time.end" />
      <button type="submit">Submit</button>
    </form>
    <canvas :id="ChartName" width="1200" height="800"></canvas>
  </div>
</template>