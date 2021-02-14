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
//= require rails-ujs
//= require activestorage
// require turbolinks
//= require_tree .

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

});


$(function(){

  $(".image-select").on("click",function(){
    $("#image").click();
  });

  $("#image").on("change", function (event) {
    var reader = new FileReader();
    reader.onload = function(event){
      $(".image-box").css({
        backgroundImage: `url(${event.target.result})`
      });
      $(".zoom-picture").css("display", "none");
    };
    reader.readAsDataURL(event.target.files[0]);
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
    $('input:radio[name="review[rating]"]').val([`${rating}`]);
  });

});


$(function(){

  $(".thumbnail").on("click",function(){
    $(".zoom-picture-area").css("display", "none");
    $(".thumb-border").css("background-color", "transparent");
    var index = $(".thumbnail").index(this);
    $(".thumb-border").eq(index).css("background-color", "#EE8F36");
    $(".zoom-picture-area").eq(index).css("display", "block");
  });

});