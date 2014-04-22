$(document).ready(function(){ 
  $(".individual_tweet").hide();

  $(".number_of_times").show();
  $(".tweet_num_0").show();

  $("td.expander").on("click", function(){
    $(this).siblings(".individual_tweet").show();
    $(this).removeClass("glyphicon-chevron-right").hide();
  });


});