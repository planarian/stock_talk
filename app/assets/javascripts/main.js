/*global $, document, window, Chart */

"use strict";

$(document).ready(function () {
  setMenu();
  setCompany();
  getData();
  window.ctx = $("#tweetChart").get(0).getContext("2d");
  window.ctx2 = $("#quoteChart").get(0).getContext("2d");
    

});


function setMenu() {
  var companyId = window.location.href.split('/').slice(-1);
  $('#company_selector').val(companyId);
}

function setCompany() {
  $('#company_selector').change(function () {
    var newUrl = $('#company_selector').val();
    window.location.replace(newUrl);
  });
}

function getData() {
  $.ajax({ type: 'GET',
    url: window.location.href}).done(function (response) {
    window.tweetChart = new Chart(ctx).Line(formatChart(response, 'tweets'), { bezierCurve: false });
    window.quoteChart = new Chart(ctx2).Line(formatChart(response, 'share_price'), { bezierCurve: false });
  });
}

function formatChart(arr, y_var) {
  return {
    labels: gapArray(Math.ceil(arr.length / 10), pluck(arr, 'day')),
    datasets: [
      {
        label: "My First dataset",
        fillColor: "rgba(220,220,220,0.2)",
        strokeColor: "rgba(220,220,220,1)",
        pointColor: "rgba(220,220,220,1)",
        pointStrokeColor: "#fff",
        pointHighlightFill: "#fff",
        pointHighlightStroke: "rgba(220,220,220,1)",
        data: pluck(arr, y_var)
      }
    ]
  };
}

function gapArray(interval, arr) {
  var len = arr.length,
    newArr = [];
  for (var i = 0; i < len; i++) {
    if (i % interval == 0)
      newArr.push(arr[i]);
    else newArr.push("");
    }
  return newArr;
}

function pluck(arr, propStr) {
  var len = arr.length,
    newArr = [];
  for (var i = 0; i < len; i++)
    newArr.push(arr[i][propStr]);
  return newArr;
}






