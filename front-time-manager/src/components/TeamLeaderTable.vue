<script>
import { get_data } from './Tools.vue'
import { getUsersByTeam, getUser } from './User.js'
import { renderChart } from './RenderChart.vue'

export async function get_teamleader_datatable(users, interval_time) {
  var total_tab = []
  for (let i in users) {
    var working_times = await get_data(users[i], interval_time)
    let tab = []
    for (let nb in working_times) {
      var start_date = new Date(working_times[nb].start)
      var end_date = new Date(working_times[nb].end)
      tab.push(Math.abs(end_date - start_date) / (3600 * 100 * 10))
    }
    let user = await getUser(users[i])
    total_tab.push([
      user['data']['username'],
      tab.reduce((partialSum, a) => partialSum + a, 0),
      1,
    ])
  }
  return [
    total_tab,
    Math.abs(
            new Date(interval_time.end.split('T', 1)+"T23:59:00") - new Date(interval_time.start.split('T', 1) + "T00:00:00"),
        ) / (3600 * 100 * 10) / 24 * 8
  ]
}

export default {
  props: ['id'],
  data() {
    return {
      timetable: [],
      ChartName: '',
      interval_time: {
        start: '2022-01-01T00:00:00',
        end: '2022-01-01T23:59:00',
      },
      rendercode: {},
    }
  },
  methods: {
    async update_range(startdate, enddate) {
      this.interval_time.start = startdate
      this.interval_time.end = enddate
      let teamleader = await getUser(this.id)
      let users = await getUsersByTeam(teamleader['data']['team_id'])
      let usernames_l = []
      for (let user in users['data']) {
        usernames_l.push(users['data'][user]['id'])
      }
      this.ChartName = 'TeamLeader'
      this.timetable = await get_teamleader_datatable(
        usernames_l,
        this.interval_time,
      )
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
    <form
      @submit.prevent="update_range(interval_time.start, interval_time.end)"
    >
      <input type="datetime-local" v-model="interval_time.start" />
      <input type="datetime-local" v-model="interval_time.end" />
      <button type="submit">Submit</button>
    </form>
    <canvas :id="ChartName" width="1200" height="800"></canvas>
  </div>
</template>
