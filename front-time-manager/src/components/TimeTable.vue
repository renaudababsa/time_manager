<script>
import { get_working_hours_user, get_working_hours_multi_users } from "./Tools.vue";
import { renderChart } from "./RenderChart.vue"

export default {
  data() {
    return {
      timetable: [],
      ChartName: ""
    }
  },
  async mounted() {
    // let username = "ababsa"
    let usernames_l = ["ababsa", "iliam"]
    // let teams_l = ["A", "B", "C"]
    let interval_time = {
      start: "2022-10-06T01:00:00",
      end: "2022-10-10T23:00:00"
    }
    this.ChartName = "USERS"
    let elapsed_time = Math.abs(new Date(interval_time.end)-new Date(interval_time.start))/(3600*100*10)
    if (typeof username === 'string') {
      this.timetable = await get_working_hours_user(username, interval_time)
      elapsed_time = 12
    } else if (typeof usernames_l === 'object') {
      this.timetable = await get_working_hours_multi_users(usernames_l, interval_time)
      elapsed_time = elapsed_time*(12/24)
    } else if (typeof teams_l === 'object') {
      this.timetable = await get_working_hours_teams(teams_l, interval_time)
      elapsed_time = elapsed_time*(12/24)
    }
    renderChart(this.timetable, this.ChartName, elapsed_time);
  }
}
</script>

<template>
  <div>
    <canvas :id=ChartName width="1200" height="800"></canvas>
  </div>
</template>
