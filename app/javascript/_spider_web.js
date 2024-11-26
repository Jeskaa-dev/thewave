data = [{
  type: 'scatterpolar',
  r: [39, 28, 8, 7, 28, 39], /* ce sont les valeurs de chaque skill */
  theta: ['HTML/CSS','JS/TS','Ruby/Back-End', 'Python', 'SQL/DB', 'Technical'],
  fill: 'toself'
}]

layout = {
  polar: {
    radialaxis: {
      visible: true,
      range: [0, 100]
    }
  },
  showlegend: false
}

Plotly.newPlot("tester", data, layout)
