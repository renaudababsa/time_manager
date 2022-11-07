<script>
import {
  get_working_hours_user,
  get_working_hours_multi_users,
} from './Tools.vue'
import { renderChart } from './RenderChart.vue'
import * as wt from './WorkingTimes.vue'
import { getWorkingTime } from './workingtime.js'

export default {
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
    this.rendercode = await getWorkingTime(
      localStorage.getItem("id"),
      startdate,
      enddate)
    },
  },
  async mounted() {
    this.update_range(this.interval_time.start, this.interval_time.end)
    console.log(this.interval_time)
    let username = 'user1'
    console.log(wt)
    // let usernames_l = ["ababsa", "iliam"]
    // let teams_l = ["A", "B", "C"]
    this.ChartName = 'USERS'
    let elapsed_time =
      Math.abs(
        new Date(this.interval_time.end) - new Date(this.interval_time.start),
      ) /
      (3600 * 100 * 10)
    if (typeof username === 'string') {
      this.timetable = await get_working_hours_user(
        username,
        this.interval_time,
      )
      elapsed_time = 12
    } else if (typeof usernames_l === 'object') {
      this.timetable = await get_working_hours_multi_users(
        usernames_l,
        this.interval_time,
      )
      elapsed_time = elapsed_time * (12 / 24)
    } else if (typeof teams_l === 'object') {
      this.timetable = await get_working_hours_teams(
        teams_l,
        this.interval_time,
      )
      elapsed_time = elapsed_time * (12 / 24)
    }
    renderChart(this.timetable, this.ChartName, elapsed_time)
  },
}
</script>

<template>
  <div>
    <form @submit.prevent="update_range(start_date, end_date)">
      <input type="datetime-local" v-model="start_date" />
      <input type="datetime-local" v-model="end_date" />
      <button type="submit">Submit</button>
    </form>
    <canvas :id="ChartName" width="1200" height="800"></canvas>
  </div>
</template>
