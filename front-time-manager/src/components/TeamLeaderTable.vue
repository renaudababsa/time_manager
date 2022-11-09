<script>
import { get_data, data_purged } from './Tools.vue'
import { getUser } from './User.js'

export async function get_teamleader_datatable(users, interval_time) {
    var total_tab = []
    for (let i in users) {
        var working_times = await get_data(users[i], interval_time)
        let tab = []
        for (let nb in working_times) {
            var start_date = new Date(working_times[nb].start)
            var end_date = new Date(working_times[nb].end)
            tab.push(Math.abs(end_date - start_date)/(3600*100*10))
        }
        let user = await getUser(users[i])
        total_tab.push([user['data']['username'], tab.reduce((partialSum, a) => partialSum + a, 0), 1])
    }
    return [
    total_tab,
    Math.abs(
            new Date(interval_time.end.split('T', 1)+"T00:00:00") - new Date(interval_time.start.split('T', 1) + "T00:00:00"),
        ) / (3600 * 100 * 10) / 24 * 8 + 8
]
}
</script>