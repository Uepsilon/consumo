// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require twitter/bootstrap
//= require_tree .


function clear_form()
{
    $(':input').not(':button, :submit, :reset, :hidden, :checkbox, :radio').val('');
    $(':checkbox, :radio').prop('checked', false);
}

function sumo_action(){
  if($('#sumo_action') && $('.alert-dismissable').hasClass('alert-success')) {
    
    $('<audio id="sumo_stomp"><source src="/assets/sumo_stomp.mp3" type="audio/mpeg"></audio>').appendTo('body');
    
    $('#sumo_stomp')[0].play();
   
    $('#sumo_action').show();

    $('#sumo_action').addClass("go").delay(300).queue(
      function(next) {
        $('#sumo_action').removeClass("error");
        $('#sumo_action').addClass("back").delay(400).queue(function(next){
          $('#container').effect( "shake", {direction: 'down', distance:'10'}  )
          $('#sumo_hai').show().delay(700).queue(function(next){
            $('#sumo_action').fadeOut();
            next();
          });
          next();
        });
        next();
      }
    );  
  }
}
