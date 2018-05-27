extends "res://util/states/state.gd"

func move_dir():
  var u = Input.is_action_pressed( "move_up" )
  var d = Input.is_action_pressed( "move_down" )
  var l = Input.is_action_pressed( "move_left" )
  var r = Input.is_action_pressed( "move_right" )

  var dir = Vector2( int(r) - int(l), int(d) - int(u) )

  return dir.normalized()
