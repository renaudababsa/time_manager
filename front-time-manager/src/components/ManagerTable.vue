<script>
import { getUsersByTeam, getUser } from './User.js'
import { get_teamleader_datatable } from './TeamLeaderTable.vue'
import { getId } from './workingtime.js'
import { getTeam, getTeams } from './Team.js'
import { renderChart } from './RenderChart.vue'

export async function get_manager_datatable(teams, interval_time) {
  let total_tab = []
  let equipe_l = []
  for (let team in teams['data']) {
    let equipe = []
    let team_l = await getUsersByTeam(teams['data'][team]['id'])
    for (let i in team_l['data']) {
      equipe.push(team_l['data'][i]['id'])
    }
    equipe_l.push(equipe)
  }
  for (let eq in equipe_l) {
    let timetable = await get_teamleader_datatable(equipe_l[eq], interval_time)
    let table = []
    for (let it in timetable[0]) {
      let tmp = timetable[0][it]
      let id = await getId(tmp[0])
      let user = await getUser(id)
      tmp.push(user['data']['team_id'])
      table.push(tmp)
    }
    let sum = []
    for (let it in table) {
      let tmp = table[it][2]
      if (tmp == table[it][2]) {
        sum.push(table[it][1])
      }
      it++
    }
    let tmp = await getTeam(table[0][3])
    total_tab.push([
        tmp['data']['name'],
        sum.reduce((partialSum, a) => partialSum + a, 0),
        table.length,
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
      level: localStorage.getItem('level'),
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
      let teams = await getTeams()
      this.ChartName = 'Manager'
      this.timetable = await get_manager_datatable(
        teams,
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
      <div class="card border-left-success shadow mb-4">
        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
          <h6 class="m-0 font-weight-bold text-success">Moyenne d'heures de toute les equipes</h6>
        </div>
      <div>
        <form
          @submit.prevent="update_range(interval_time.start, interval_time.end)"
        >
        <div class="grid">
          <div class="row">
            <div class="col-xl-5 col-lg-6">
                <input class="form-control" type="datetime-local" v-model="interval_time.start" />
            </div>
            <div class="col-xl-5 col-lg-6">
                <input class="form-control" type="datetime-local" v-model="interval_time.end" />
            </div>
            <div class="col-xl-2 col-lg-12">
              <button class="btn btn-primary" type="submit">Changer</button>
            </div>
          </div>
        </div>
        </form>
        <canvas :id="ChartName" width="1200" height="800"></canvas>
      </div>
    </div>
</template>
