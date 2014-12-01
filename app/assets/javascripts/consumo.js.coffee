window.sumo_action = ->
  if $("#sumo_action") and $(".alert-dismissable").hasClass("alert-success")
    $("<audio id='sumo_stomp'><source src='https://drunken-bartender.s3.amazonaws.com/misc/development/sumo_stomp.mp3' type='audio/mpeg'></audio>").appendTo "body"
    $("#sumo_stomp")[0].play()
    $("#sumo_action").show()
    $("#sumo_action").addClass("go").delay(300).queue (next) ->
      $("#sumo_action").removeClass "error"
      $("#sumo_action").addClass("back").delay(400).queue (next) ->
        $("#container").effect "shake",
          direction: "down"
          distance: "10"

        $("#sumo_hai").show().delay(700).queue (next) ->
          $("#sumo_action").fadeOut()
          next()
          return
        next()
        return
      next()
      return
  return

window.toggle_order_item = (element) ->
  $(element).next().toggle null, ->
    sub_element = $(element).children('.toggle_icon')
    if $(sub_element).hasClass('glyphicon-chevron-up')
      sub_element.removeClass('glyphicon-chevron-up').addClass('glyphicon-chevron-down')
    else
      sub_element.removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-up')

window.toggle_stats = ->
  $('#dashboard').children('.stats').toggle()
  if $('#dashboard').find('.toggle_icon').hasClass('glyphicon-chevron-up')
      $('#dashboard').find('.toggle_icon').removeClass('glyphicon-chevron-up').addClass('glyphicon-chevron-down')
  else
    $('#dashboard').find('.toggle_icon').removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-up')
