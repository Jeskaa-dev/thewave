document.addEventListener("DOMContentLoaded", () => {
  const data = [{
    type: 'scatterpolar',
    r: [80, 60, 25, 40], /* ce sont les valeurs de chaque skill */
    theta: ['HTML/CSS', 'Javascript', 'SQL & DB', 'Ruby on Rails'], /* ce sont les noms des skills */
    fill: 'toself'
  }]

  const layout = {
    polar: {
      radialaxis: {
        visible: true,
        range: [0, 100] /* c'est l'échelle de 0 à 100 */
      }
    },
      showlegend: false
  }
  Plotly.newPlot("tester", data, layout)
}
)
