<script>
import * as request from './workingtime.js'

export async function get_data(username, interval_time) {
  return await request.getWorkingTime(await request.getId(username), interval_time.start, interval_time.end)
}

export function data_purged(tab) {
    const array = [];
    for(var i = 0; i < tab.length; i++) {
        const array2 = array.map(item => item[0]);
        if (!array2.includes(tab[i][0]))
        array.push(tab[i]);
        else {
            const idx = array2.indexOf(tab[i][0])
            array[idx] = [array[idx][0], tab[i][1]+array[idx][1]]
        }
    }
    return array
}

export async function get_working_hours_user(username, interval_time) {
  var working_times = await get_data(username, interval_time)
  let tab = []
  for (let nb in working_times) {
    var start_date = new Date(working_times[nb].start)
    var end_date = new Date(working_times[nb].end)
    var date = working_times[nb].start.split('T', 1)
    tab.push([date[0], Math.abs(end_date - start_date)/(3600*100*10)])
  }
  return data_purged(tab);
}

export async function get_working_hours_multi_users(users, interval_time) {
    var total_tab = []
    for (let i in users) {
        var working_times = await get_data(users[i], interval_time)
        let tab = []
        for (let nb in working_times) {
            var start_date = new Date(working_times[nb].start)
            var end_date = new Date(working_times[nb].end)
            tab.push(Math.abs(end_date - start_date)/(3600*100*10))
        }
        total_tab.push([users[i], tab.reduce((partialSum, a) => partialSum + a, 0)])
    }
    return total_tab;
}
</script>