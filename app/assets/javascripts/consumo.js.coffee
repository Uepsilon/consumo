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

