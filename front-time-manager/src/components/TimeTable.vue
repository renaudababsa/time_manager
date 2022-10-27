<script>
import Chart from 'chart.js/auto';
// import * as Utils from "./Utils.vue";

function get_data() {
  return (fetch("/data.json")
          .then((res) => {
            return res.json();
          })
          .then((data) => data))
}

async function working_hours() {
  var working_times = await get_data()
  var sum_monday = 0
  for (let nb in working_times) {
    var start_date = new Date(working_times[nb].start)
    var end_date = new Date(working_times[nb].end)
    var user_id = working_times[nb].user_id
    sum_monday += Math.abs(end_date - start_date)/(3600*100*10);
  }
  console.log(sum_monday)
  return sum_monday;
}

export default {
  name: 'HelloWord',
  data() {
    return {
      sum_monday: 0
    }
  },
  props: {
    msg: String
  },
  async mounted() {
    this.sum_monday = await working_hours()
    console.log(this.sum_monday)
    console.log('Component mounted.')
    const ctx = document.getElementById('myChart');
    const data = {
      labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      datasets: [{
        label: 'Emploi du temps',
        data: [this.sum_monday, 12, 6, 9, 12, 3, 9],
        backgroundColor: [
        'rgba(255, 26, 104, 0.2)',
        'rgba(54, 162, 235, 0.2)',
        'rgba(255, 206, 86, 0.2)',
        'rgba(75, 192, 192, 0.2)',
        'rgba(153, 102, 255, 0.2)',
        'rgba(255, 159, 64, 0.2)',
        'rgba(0, 0, 0, 0.2)'
        ],
        borderColor: [
        'rgba(255, 26, 104, 1)',
        'rgba(54, 162, 235, 1)',
        'rgba(255, 206, 86, 1)',
        'rgba(75, 192, 192, 1)',
        'rgba(153, 102, 255, 1)',
        'rgba(255, 159, 64, 1)',
        'rgba(0, 0, 0, 1)'
        ],
        borderWidth: 1
      },
      {
        label: 'Weekly Sales',
        data: [9, 4, 8, 9, 12, 3, 9],
        backgroundColor: [
        'rgba(255, 26, 104, 0.2)',
        'rgba(54, 162, 235, 0.2)',
        'rgba(255, 206, 86, 0.2)',
        'rgba(75, 192, 192, 0.2)',
        'rgba(153, 102, 255, 0.2)',
        'rgba(255, 159, 64, 0.2)',
        'rgba(0, 0, 0, 0.2)'
        ],
        borderColor: [
        'rgba(255, 26, 104, 1)',
        'rgba(54, 162, 235, 1)',
        'rgba(255, 206, 86, 1)',
        'rgba(75, 192, 192, 1)',
        'rgba(153, 102, 255, 1)',
        'rgba(255, 159, 64, 1)',
        'rgba(0, 0, 0, 1)'
        ],
        borderWidth: 1
      }]
    };
    
    const myChart = new Chart(ctx, {
      type: 'bar',
      data,
      options: {
        scales: {
          y: {
            max: 12,
            min: 0,
          }
        }
      }
    });
    myChart;
  }
}
</script>

<template>
  <div>
    <canvas id="myChart" width="1200" height="800"></canvas>
  </div>
</template>