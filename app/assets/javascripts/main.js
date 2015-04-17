/*global $, document, window, Chart */

"use strict";


$(document).ready(function () {

  if ($("#tweetChart").length) {
    setMenu();
    setCompany();
    clickListener("#tweetChart", "tweets")();
    clickListener("#priceChart", "prices")();

    getAndGraphData({key: 'tweets', tag: $('#tweetChart')[0], opt: {highlightCallback: tweetHighlight, 
                                                                    drawCallback: tweetDraw}},
                    {key: 'prices', tag: $('#priceChart')[0], opt: {highlightCallback: priceHighlight,
                                                                    drawCallback: priceDraw}});

    window.globalVars = {};
    globalVars.clicked = null;

    // tweetClickListener();
    // priceClickListener();
  }



});

//begin callbacks

function clickListener(tag, statusName) {
  return function () {
    $(tag).mousedown(function () {
      globalVars.clicked = statusName;
    });
  };

}

// function tweetClickListener() {
//   $("#tweetChart").mousedown(function () {
//     globalVars.clicked = "tweets";
//   });
// }

// function priceClickListener() {
//   $("#priceChart").mousedown(function () {
//     globalVars.clicked = "prices";
//   });
// }


function tweetHighlight(event, x, points, row, seriesName) {
  globalVars.prices.setSelection(row);
}

function priceHighlight(event, x, points, row, seriesName) {
  globalVars.tweets.setSelection(row);
}

function tweetDraw(dygraph, is_initial) {
  if (!is_initial)
    if (globalVars.clicked === "tweets") {
      var dateRange = dygraph.xAxisRange(),
      minDate = dateRange[0],
      maxDate = dateRange[1];
      globalVars.prices.updateOptions({dateWindow: [minDate, maxDate]});
    }
}


function priceDraw(dygraph, is_initial) {
  if (!is_initial) 
    if (globalVars.clicked === "prices") {
      var dateRange = dygraph.xAxisRange(),
      minDate = dateRange[0],
      maxDate = dateRange[1];
      globalVars.tweets.updateOptions({dateWindow: [minDate, maxDate]});
    }
}

//end callbacks



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

function getAndGraphData() { //accepts series of {key: <str>, tag: <elem>} objects
  var args = arguments,
    argLen = arguments.length;

  $.ajax({ type: 'GET',
    url: window.location.href}).done(function (response) {

    for (var i = 0; i < argLen; i++)
      graphData(args[i].key, args[i].tag, response[args[i].key], args[i].opt);
  });
}

function graphData(key, tag, csv, opt) {
  globalVars[key] = new Dygraph(tag, csv, opt);
}





