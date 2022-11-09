<script>
import { get_data, data_purged } from './Tools.vue'
import { renderChart } from './RenderChart.vue'

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
      this.ChartName = 'USERS'
      this.timetable = await get_employee_datatable(this.id, this.interval_time)
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
