# player_camera.gd

extends Camera2D

var player_pos = null
var mouse_pos  = null

func update_offset():
  set_offset( (mouse_pos - player_pos)/2 )
  # print( get_offset() )
  pass

func _input( ev ):
  if ev is InputEventMouseMotion:
    # NOTE get_global_mouse_position() gets the cursor's world-coords,
    # but is only available from CanvasItems
    # this is in favour of ev.get_position() or ev.get_global_position(), which
    # are relative to the viewport (always positive)
    mouse_pos = get_global_mouse_position()
    update_offset()

func set_player_pos( pos ):
  player_pos = pos
  mouse_pos = pos

func _on_Player_move( old_pos, new_pos ):
  player_pos = new_pos
  update_offset()
