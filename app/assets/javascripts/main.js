$(document).ready(function() {
      
  setMenu();
  setCompany();

  var ctx = $("#myChart").get(0).getContext("2d");
  // var myNewChart = new Chart(ctx);
  var myLineChart = new Chart(ctx).Line(data);

});

function setMenu() {
  companyId = window.location.href.split('/').slice(-1);
  $('#company_selector').val(companyId);
}

function setCompany() {
  $('#company_selector').change(function() {
    newUrl = $('#company_selector').val();
    window.location.replace(newUrl);
  });
}





