extends '../motion.gd'

func _init():
  ID = 'idle'

func _on_enter( fsm ):
  # set animation to idle
  return ._on_enter( fsm )

func _on_leave( fsm ):
  return ._on_leave( fsm )

func _update( fsm, delta ):
  return ._update( fsm, delta )

func _physics_update( fsm, delta ):
  # if dodge

  if move_dir() != Vector2( 0.0, 0.0 ):
    return 'move'

  return ._physics_update( fsm, delta )

func _parse_input( fsm, ev ):
  return ._parse_input( fsm, ev )

func _parse_unhandled_input( fsm, ev ):
  return ._parse_unhandled_input( fsm, ev )

func _on_animation_finished( fsm, ani_name ):
  return ._on_animation_finished( fsm, ani_name )
