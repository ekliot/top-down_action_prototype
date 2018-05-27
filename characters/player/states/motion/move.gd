extends '../motion.gd'

export (float) var SPRINT_MAX   = 1.5
export (float) var SPRINT_ACCEL = 1.5

var sprinting = false

func _init():
  ID = 'move'

# ========= #
# STATE BIZ #
# ========= #

func _on_enter( fsm ):
  check_sprint()
  # play movement animation
  return ._on_enter( fsm )

func _on_leave( fsm ):
  sprinting = false
  return ._on_leave( fsm )

func _update( fsm, delta ):
  return ._update( fsm, delta )

func _physics_update( fsm, delta ):
  # update my velocity based on where I want to move
  if check_sprint():
    fsm.host.set_velocity( move_dir(), SPRINT_MAX, SPRINT_ACCEL )
  else:
    fsm.host.set_velocity( move_dir() )

  # if we've stopped moving (including hitting a wall), return to our last state (idle)
  if fsm.host.velocity.abs().floor() == Vector2( 0.0, 0.0 ):
    return fsm.OP_POP

  return ._physics_update( fsm, delta )

func _parse_input( fsm, ev ):
  return ._parse_input( fsm, ev )

func _parse_unhandled_input( fsm, ev ):
  # handle dodge
  # handle roll
  # handle attack
  # handle parry
  return ._parse_unhandled_input( fsm, ev )

func _on_animation_finished( fsm, ani_name ):
  return ._on_animation_finished( fsm, ani_name )

# ============ #
# CORE METHODS #
# ============ #

func check_sprint():
  sprinting = Input.is_action_pressed( 'sprint' )
  return sprinting
