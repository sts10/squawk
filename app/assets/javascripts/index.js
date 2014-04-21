$(document).ready(function(){ 

  $('#get_squawks').on("mouseover", function(){
    $('#parrot').css("top", "-10px");
    $('#get_squawks').css("color", "#A4D3E4");
  });

  $('#get_squawks').on("mouseleave", function(){
    $('#parrot').css("top", "0px");
    $('#get_squawks').css("color", "#fff");
  });

  $('#get_squawks').on("mousedown", function(){
    $('#parrot').css("top", "0px");
    $('#get_squawks').css("color", "#A4D3E4");
  });

});