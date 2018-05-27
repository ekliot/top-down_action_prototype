extends '../motion.gd'

func _init():
  ID = 'move'

func _on_enter( fsm ):
  # play movement animation
  return ._on_enter( fsm )

func _on_leave( fsm ):
  return ._on_leave( fsm )

func _parse_unhandled_input( fsm, ev ):
  # handle dodge
  # handle roll
  # handle attack
  # handle parry
  return ._parse_unhandled_input( fsm, ev )

func _on_animation_finished( fsm, ani_name ):
  return ._on_animation_finished( fsm, ani_name )

func _physics_update( fsm, delta ):
  # update my velocity based on where I want to move
  fsm.host.set_velocity( move_dir() )

  # if we've stopped moving (including hitting a wall), return to our last state (idle)
  if fsm.host.velocity.abs().floor() == Vector2( 0.0, 0.0 ):
    return fsm.OP_POP
