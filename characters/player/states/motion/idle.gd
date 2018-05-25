extends '../motion.gd'

func _init():
  ID = 'idle'

func _on_enter( fsm ):
  # set animation to idle
  return ._on_enter( fsm )

func _parse_unhandled_input( fsm, ev ):
  if move_dir() != Vector2( 0.0, 0.0 ):
    return 'move'

  return ._parse_unhandled_input( fsm, ev )
