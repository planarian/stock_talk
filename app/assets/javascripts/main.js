/*global $, document, window, Chart */

"use strict";


$(document).ready(function () {

  if ($("#tweetChart").length) {
    window.globalVars = {};
    globalVars.clicked = null;

    setMenu();
    setCompany();
    
  
    createClickCallback("#tweetChart", "tweets")();
    createClickCallback("#priceChart", "prices")();

    getAndGraphData({series: 'tweets', tag: $('#tweetChart')[0], opt: {highlightCallback: createHighlightCallback("prices"), 
                                                                    drawCallback: createDrawCallback("tweets", "prices")}},
                    {series: 'prices', tag: $('#priceChart')[0], opt: {highlightCallback: createHighlightCallback("tweets"),
                                                                    drawCallback: createDrawCallback("prices", "tweets")}});
  
  }
});


function createClickCallback(tag, statusName) {
  return function () {
    $(tag).mousedown(function () {
      globalVars.clicked = statusName;
    });
  };

}

function createHighlightCallback(otherGraph) {
  return function (event, x, points, row, seriesName) {
    globalVars[otherGraph].setSelection(row);
  };
}

function createDrawCallback(thisGraph, otherGraph) {
  return function (dygraph, is_initial) {
    if (!is_initial)
      if (globalVars.clicked === thisGraph) {
        var dateRange = dygraph.xAxisRange(),
        minDate = dateRange[0],
        maxDate = dateRange[1];
        globalVars[otherGraph].updateOptions({dateWindow: [minDate, maxDate]});
      }
  };
}


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

function getAndGraphData() { //accepts set of {series: <str>, tag: <elem>} objects
  var args = arguments,
    argLen = arguments.length;

  $.ajax({ type: 'GET',
    url: window.location.href}).done(function (response) {

    for (var i = 0; i < argLen; i++)
      graphData(args[i].series, args[i].tag, response[args[i].series], args[i].opt);
  });
}

function graphData(series, tag, csv, opt) {
  globalVars[series] = new Dygraph(tag, csv, opt);
}





