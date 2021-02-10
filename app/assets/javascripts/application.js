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
//= require turbolinks
//= require_tree .

$(function(){

  $(".image-select").on("click",function(event){
    $("#item_item_pictures_attributes_0_image").click();
  });

  $("#item_item_pictures_attributes_0_image").on("change", function (event) {
    var reader = new FileReader();
    reader.onload = function(event){
      $(".item-image-box").css({
        backgroundImage: `url(${event.target.result})`
      });
    };
    reader.readAsDataURL(event.target.files[0]);
  });

});

$(function(){

  $("#select-star i").on("click",function(event){
    $("#select-star i").css("color", "#CCC");
    $(this).css("color", "#E6B86F");
    $(this).prevAll().css("color", "#E6B86F");
    var index = $("#select-star i").index(this);
    var rating = Number(index) + 1
    $('input:radio[name="review[rating]"]').val([`${rating}`]);

  });

});