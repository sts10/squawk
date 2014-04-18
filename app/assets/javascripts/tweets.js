$(document).ready(function(){
  // $("div.tweets").hide();
  // $("a#hide_tweets").hide();

  // $("a#show_tweets").on("click", function(e){
  //   $(this).siblings("div.tweets").slideDown();
  //   $(this).hide();
  //   $(this).siblings("a#hide_tweets").show();

  // });

  // $("a#hide_tweets").on("click", function(e){
  //   $(this).siblings("div.tweets").slideUp();
  //   $(this).siblings("a#show_tweets").show();
  //   $(this).hide();
  // });

  // alert("this works");

  
  $(".individual_tweet").hide();

  // $(".number_of_times").show();
  $(".tweet_num_0").show();
  // $(".arrow").show();

  $("td.expander").on("click", function(){
    $(this).siblings(".individual_tweet").show();
    $(this).removeClass("glyphicon-chevron-right").hide();
  });

  // $('div#carousel-example-generic').carousel()



});