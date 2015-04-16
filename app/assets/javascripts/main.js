/*global $, document, window, Chart */

"use strict";

$(document).ready(function () {

  if ($("#tweetChart").length) {
    setMenu();
    setCompany();
    
    getAndGraphData({key: 'tweets', tag: $('#tweetChart')[0]}, 
                     {key: 'prices', tag: $('#priceChart')[0]});
  }

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

function getAndGraphData() { //accepts series of {key: <str>, tag: <elem>} objects
  var args = arguments,
    argLen = arguments.length;

  $.ajax({ type: 'GET',
    url: window.location.href}).done(function (response) {

    for (var i = 0; i < argLen; i++)
      graphData(args[i].key, args[i].tag, response[args[i].key]);
  });
}

function graphData(key, tag, csv) {
  window[key] = new Dygraph(tag, csv);
}





