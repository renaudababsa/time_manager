<script>
import { get_data, data_purged } from './Tools.vue'
import { renderChart } from './RenderChart.vue'
import { getUsers } from './User'

export async function get_employee_datatable(id, interval_time) {
  var working_times = await get_data(id, interval_time)
  let tab = []
  for (let nb in working_times) {
    var start_date = new Date(working_times[nb].start)
    var end_date = new Date(working_times[nb].end)
    var date = working_times[nb].start.split('T', 1)
    tab.push([date[0], Math.abs(end_date - start_date) / (3600 * 100 * 10)])
  }
  return [data_purged(tab), 8]
}

export default {
  props: ['id'],
  data() {
    return {
      selected_id: this.id,
      users: {},
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
    async update_range(id, startdate, enddate) {
      this.interval_time.start = startdate
      this.interval_time.end = enddate
      this.ChartName = 'USERS'
      this.timetable = await get_employee_datatable(id, this.interval_time)
      renderChart(this.timetable[0], this.timetable[1], this.ChartName)
    },
  },
  async mounted() {
    if (this.level >= 3) {
      this.users = await getUsers();
    }
    this.update_range(this.selected_id, this.interval_time.start, this.interval_time.end)
  },
}
</script>

<template>
      <div class="card border-left-primary shadow mb-4">
        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
          <h6 class="m-0 font-weight-bold text-primary">Heures passages par jour</h6>
        </div>
      <div>
        <form
          @submit.prevent="update_range(selected_id, interval_time.start, interval_time.end)"
        >
        <div class="grid">
        <div class="row">
          <div class="col-xl-3 col-lg-6">
              <input class="form-control" type="datetime-local" v-model="interval_time.start" />
          </div>
          <div class="col-xl-3 col-lg-6">
              <input class="form-control" type="datetime-local" v-model="interval_time.end" />
          </div>
          <div v-if="level >= 3" class="col-xl-4 col-lg-6">
            <select class="form-select" v-model="selected_id">
              <option v-for="user in users['data']" :value="user.id">{{user.username}}</option>
            </select>
          </div>
          <div class="col-xl-2 col-lg-6">
            <button class="btn btn-primary" type="submit">Changer</button>
          </div>
        </div>
        </div>
        </form>
        <canvas :id="ChartName" width="1200" height="800"></canvas>
      </div>
    </div>
</template>
