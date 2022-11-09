
<script>
import { get_data, data_purged } from './Tools.vue'

export async function get_employee_datatable(id, interval_time) {
  var working_times = await get_data(id, interval_time)
  let tab = []
  for (let nb in working_times) {
    var start_date = new Date(working_times[nb].start)
    var end_date = new Date(working_times[nb].end)
    var date = working_times[nb].start.split('T', 1)
    tab.push([date[0], Math.abs(end_date - start_date)/(3600*100*10)])
  }
  return [
    data_purged(tab),
    8
    ];
}
</script>