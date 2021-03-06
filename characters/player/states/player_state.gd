extends "res://util/states/state.gd"

# ========= #
# OVERRIDES #
# ========= #

# ============ #
# CORE METHODS #
# ============ #

func cap_velocity( vel, cap ):
  return Vector2( min( max( vel.x, -cap.x ), cap.x ),
                  min( max( vel.y, -cap.y ), cap.y ) )

func apply_friction_flt( flt, friction ):
  return lerp( flt, 0.0, friction )

func apply_friction_vec( vec, friction ):
  return Vector2( lerp( vec.x, 0.0, friction ), lerp( vec.y, 0.0, friction ) )

func update_velocity( vel, accel, dir ):
  return vel + accel * dir

func move_dir():
  var u = Input.is_action_pressed( "move_up" )
  var d = Input.is_action_pressed( "move_down" )
  var l = Input.is_action_pressed( "move_left" )
  var r = Input.is_action_pressed( "move_right" )

  var dir = Vector2( int(r) - int(l), int(d) - int(u) )

  return dir.normalized()

func dir_as_str( dir ):
  var angle = dir.angle()
  # TODO switch based on angle returning one of:
  #   - 'up'
  #   - 'down'
  #   - 'left'
  #   - 'right'
  return ''

func move_dir_as_str():
  return dir_as_str( move_dir() )
