import Chart from 'chart.js'

function GrossProfitGraph(element, labels, values) {
  // -----------
  // Constructor

  this.values = values;
  this.element = $(element);
  this.labels = labels;

  var width = this.element.width();
  var canvas = this.element.find('canvas');
  canvas.prop({
    height: 300,
    width: width
  });

  //Get the context of the canvas element we want to select
  var context = canvas.get(0).getContext("2d");

  var areaColor = "rgba(0,255,140,0.9)";
  var lineColor = "rgba(0,237,102,1)";

  var data = {
    labels: labels,
    datasets: [{
      data: values,
      backgroundColor: areaColor,
      borderColor: lineColor,
      lineTension: 0,
      pointBackgroundColor: lineColor,
      pointBorderColor: lineColor,
    }]
  };

  var options = {
    legend: {
      display: false
    },
    maintainAspectRatio: false,
    responsive: true,
    scales: {
      yAxes: [{
        ticks: {
          display: false
        }
      }]
    },
  };

  var grossProfitChart = new Chart(
    context,
    {
      type: 'line',
      data: data,
      options: options
    }
  );
};

$(document).ready(function() {
  var graph = new GrossProfitGraph(
    $('.graph'),
    ["2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016"],
    [8, 1194, 1542, 1658, 1355, 4690, 5088, 5304]
  );
})
