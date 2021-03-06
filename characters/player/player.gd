# player.gd

extends '../character.gd'

export (float) var SPRINT_MAX   = 1.5
export (float) var SPRINT_ACCEL = 1.5

# ========= #
# OVERRIDES #
# ========= #

func _ready():
  fsm.start( 'idle' )
  $PlayerCamera.set_player_pos( get_position() )

  connect( 'update_position', self, '_on_move' )
  connect( 'update_position', $PlayerCamera, '_on_Player_move' )

func _process( delta ):
  pass

func _input( ev ):
  if ev is InputEventMouseMotion:
    # NOTE get_global_mouse_position() gets the cursor's world-coords,
    # but is only available from CanvasItems
    # this is in favour of ev.get_position() or ev.get_global_position(), which
    # are relative to the viewport (always positive)
    lookat_mouse()

# ====== #
# PUBLIC #
# ====== #

func animate( anim_name ):
  print( 'player.gd // starting anim: ', anim_name  )
  return .animate( anim_name )

func get_active_weapon():
  # TEMP
  return $Weapon

func get_move_data():
  var _mdat = .get_move_data()
  _mdat['sprint'] = { 'max': SPRINT_MAX, 'accel': SPRINT_ACCEL }
  return _mdat

# ======= #
# HELPERS #
# ======= #

func lookat_mouse():
  var dir = ( get_global_mouse_position() - get_position() ).normalized()
  set_look_dir( dir )
  # TEMP
  set_rotation( -dir.angle_to( Vector2( 0, -1 ) ) )
  # update animation based on direction and current state

func _on_move( old_pos, new_pos ):
  lookat_mouse()
