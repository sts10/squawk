$(document).ready(function(){
  $("div#tweets").hide();

  $("a#show_tweets").on("click", function(e){
    $("div#tweets").show();
  })
});