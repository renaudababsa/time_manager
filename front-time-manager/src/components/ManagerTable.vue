<script>
import { getUsersByTeam, getUser } from './User.js'
import { data_purged, get_data } from './Tools.vue'
import { get_teamleader_datatable } from './TeamLeaderTable.vue'
import { getId } from './workingtime.js'
import { getTeam } from './Team.js'

export async function get_manager_datatable(teams, interval_time) {
  let total_tab = []
  let manager = await getUser(3)
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
            new Date(interval_time.end.split('T', 1)+"T00:00:00") - new Date(interval_time.start.split('T', 1) + "T00:00:00"),
        ) / (3600 * 100 * 10) / 24 * 8 + 8
  ]
}
</script>
