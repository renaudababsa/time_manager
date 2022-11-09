<script>
import * as request from './workingtime.js'

export async function get_data(id, interval_time) {
  return await request.getWorkingTime(id, interval_time.start, interval_time.end)
}

export function data_purged(tab) {
    const array = [];
    for (var i = 0; i < tab.length; i++) {
        const array2 = array.map(item => item[0]);
        if (!array2.includes(tab[i][0]))
        array.push(tab[i]);
        else {
            const idx = array2.indexOf(tab[i][0])
            array[idx] = [array[idx][0], tab[i][1]+array[idx][1]]
        }
    }
    for (i in array) {
        array[i].push(1)
    }
    return array
}

</script>