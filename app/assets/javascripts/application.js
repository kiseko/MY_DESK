// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.jscroll.min.js
//= require rails-ujs
//= require activestorage
// require turbolinks
//= require_tree .

$(function(){

  $(window).load(function(){
    $(".loading-field").css("display", "none");
    $("main").css("position", "static");
  });

});

$(function(){

  $(".my-desk-login").hover(function(){
    $(".desk-line-icon, .my-desk-info").toggleClass("active");
    $(".desker-search, .item-search").removeClass("in");
  });

  $(".user-setting-trigger, .rectangle-panel").hover(function(){
    $(".user-setting-info").toggleClass("active");
    $(".desker-search, .item-search").removeClass("in");
  });

  $(".search-trigger, .sp-search-trigger").on("click",function(){
    $(this).toggleClass("active");
    $(".two-line-icon").toggleClass("active");
    $(".desker-search, .item-search").toggleClass("in");
  });

  $(".target-item").on("click",function(){
    $(".desker-search").css("display", "none");
    $(".item-search").css("display", "block");
  });
  $(".target-desker").on("click",function(){
    $(".item-search").css("display", "none");
    $(".desker-search").css("display", "block");
  });

   $(window).scroll(function(){
    var scroll = $(window).scrollTop();
    if (scroll > 0) {
      $(".sub-header-info").addClass("out");
      $(".search-trigger, .two-line-icon").removeClass("active");
      $(".desker-search, .item-search").removeClass("in");
    }
    else {
      $(".sub-header-info").removeClass("out");
    }
  });

});


$(function(){

  $(window).scroll(function(){
    var scroll = $(window).scrollTop();
    if (scroll > 0) {
      $(".user-information").addClass("fade-out");
    }
    else {
      $(".user-information").removeClass("fade-out");
    }
  });

  $(".bubble").on("click",function(){
    $(".main-picture-area").css("display", "none");
    $(".scene-delete").css("display", "none");
    $(".desk-item").css("display", "none");
    $(".bubble").css("background-color", "transparent");
    $(this).css("background-color", "#5EA1A9");
    var index = $(".bubble").index(this);
    $(".main-picture-area").eq(index).css("display", "block");
    $(".scene-delete").eq(index).css("display", "block");
    $(".desk-item").eq(index).css("display", "block");
  });

});


$(function(){

  $(".image-select").on("click",function(){
    $("#image").click();
  });

  $("#image").on("change", function (event) {
    var reader = new FileReader();
    reader.onload = function(event){
      $(".image-box").css({
        backgroundImage: "url(" + event.target.result + ")"
      });
      $(".main-picture").css("opacity", "0");
    };
    reader.readAsDataURL(event.target.files[0]);
  });

});


$(function(){

  $(".three-dots").on("click",function(){
    var index = $(".three-dots").index(this);
    $(".mute-icon").eq(index).toggleClass("appearance");
    $(".block-icon").eq(index).toggleClass("appearance");
  });

});


$(function(){

  $(document).on("ready page:load", function() {
    var rating = $('input:radio[name="review[rating]"]:checked').val();
    if (rating>= 1 && rating <= 5){
      $("#select-star i").slice(0, rating).css("color", "#E6B86F");
    }
  });


  $("#select-star i").on("click",function(){
    $("#select-star i").css("color", "#CCC");
    $(this).css("color", "#E6B86F");
    $(this).prevAll().css("color", "#E6B86F");
    var index = $("#select-star i").index(this);
    var rating = Number(index) + 1
    $('input:radio[name="review[rating]"]').val([rating]);
  });

});


$(function(){

  $(".thumbnail").on("click",function(){
    $(".main-picture-area").css("display", "none");
    $(".thumb-box .delete-button").css("display", "none");
    $(".thumb-border").css("background-color", "transparent");
    var index = $(".thumbnail").index(this);
    $(".thumb-border").eq(index).css("background-color", "#EE8F36");
    $(".main-picture-area").eq(index).css("display", "block");
    if (index != 0) {
      $(".thumb-box .delete-button").eq(index).css("display", "block");
    }
  });

});


$(function() {
  $(".jscroll").jscroll({
    contentSelector: ".jscroll",
    nextSelector: "span.next:last a",
  });
});