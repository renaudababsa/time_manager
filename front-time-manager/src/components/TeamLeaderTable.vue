<script>
import { get_data } from './Tools.vue'
import { getUsersByTeam, getUser } from './User.js'
import { renderChart } from './RenderChart.vue'
import { getTeams } from './Team.js'

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
      selected_id: '',
      teams: {},
      level: localStorage.getItem('level'),
      interval_time: {
        start: '2022-01-01T00:00:00',
        end: '2022-01-01T23:59:00',
      },
      rendercode: {},
    }
  },
  methods: {
    async update_range(argid, startdate, enddate) {
      this.interval_time.start = startdate
      this.interval_time.end = enddate
      let users = await getUsersByTeam(argid)
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
    let user = await getUser(this.id);
    this.selected_id = user['data']['team_id']
    if (this.level >= 3)
      this.teams = await getTeams();
    this.update_range(this.selected_id, this.interval_time.start, this.interval_time.end)
  },
}
</script>

<template>
    <div class="card border-left-info shadow mb-4">
        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
          <h6 class="m-0 font-weight-bold text-info">Moyenne d'heures d'une equipe</h6>
        </div>
      <div class="card-body">
        <form
          @submit.prevent="update_range(selected_id, interval_time.start, interval_time.end)"
        >
        <div class="row">
          <div class="col-xl-3 col-lg-6">
              <input class="form-control" type="datetime-local" v-model="interval_time.start" />
          </div>
          <div class="col-xl-3 col-lg-6">
              <input class="form-control" type="datetime-local" v-model="interval_time.end" />
          </div>
          <div v-if="level >= 3" class="col-xl-3 col-lg-6">
            <select class="form-select" v-model="selected_id">
              <option v-for="team in teams['data']" :value="team.id">{{team.name}}</option>
            </select>
          </div>
          <div class="col-xl-3 col-lg-6">
            <button class="btn btn-primary" type="submit">Changer</button>
          </div>
        </div>
        </form>
        <canvas :id="ChartName" width="1200" height="800"></canvas>
      </div>
    </div>
</template>
