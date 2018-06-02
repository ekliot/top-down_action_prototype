extends 'res://util/states/state.gd'

# data must at least have:
#   - 'duration'
var recover_data = {}
var elapsed = 0

func _init():
  ID = 'recover'

func _on_enter( fsm, last_state, state_data ):
  recover_data = state_data
  elapsed = 0
  return ._on_enter( fsm, last_state, recover_data )

func _on_leave( fsm ):
  fsm.set_state_data( ID, {} )
  recover_data = {}

  return ._on_leave( fsm )

func _update( fsm, delta ):
  return ._update( fsm, delta )

func _physics_update( fsm, delta ):
  elapsed += delta

  if elapsed >= recover_data.duration:
    return fsm.START_STATE

  return ._physics_update( fsm, delta )

func _parse_input( fsm, ev ):
  return ._parse_input( fsm, ev )

func _parse_unhandled_input( fsm, ev ):
  return ._parse_unhandled_input( fsm, ev )

func _on_animation_finished( fsm, ani_name ):
  return ._on_animation_finished( fsm, ani_name )
