<script>
import Chart from 'chart.js/auto';

export function renderChart(Timetable, elapsed_time, ChartName) {
    const labels = []
    const workingtimes = []
    for (var elem in Timetable) {
        labels.push(Timetable[elem][0])
        workingtimes.push(Timetable[elem][1])
    }
    console.log(Timetable[elem][0],Timetable[elem][1],elapsed_time)
    const ctx = document.getElementById(ChartName);
    const data = {
        labels: labels,
        datasets: [{
            label: 'Temps de travail',
            data: workingtimes,
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
            label: 'Horaire prévu',
            data: Array(labels.length).fill(Math.round(elapsed_time*Timetable[elem][2])),
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
    let chartStatus = Chart.getChart(ChartName);
    if (chartStatus != undefined) {
        chartStatus.destroy();
    }  
    const myChart = new Chart(ctx, {
        type: 'bar',
        data,
        options: {
            scales: {
                y: {
                    max: Math.round(elapsed_time*(11/10)*Timetable[elem][2]),
                    min: 0,
                }
            }
        }
    });
    myChart;
}
</script>