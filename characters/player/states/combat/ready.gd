extends "res://util/states/state.gd"

# data must at least have:
#   - 'duration'
#   - 'next_state'
var ready_data = {}
var elapsed = 0

func _init():
  ID = 'ready'

func _on_enter( fsm, last_state, state_data ):
  ready_data = state_data
  elapsed = 0
  fsm.host.apply_velocity( Vector2( 0, 0 ) )
  return ._on_enter( fsm, last_state, state_data )

func _on_leave( fsm ):
  fsm.set_state_data( ID, {} )
  ready_data = {}

  return ._on_leave( fsm )

func _update( fsm, delta ):
  return ._update( fsm, delta )

func _physics_update( fsm, delta ):
  elapsed += delta

  if elapsed >= ready_data.duration:
    return ready_data.next_state

  return ._physics_update( fsm, delta )

func _parse_input( fsm, ev ):
  return ._parse_input( fsm, ev )

func _parse_unhandled_input( fsm, ev ):
  return ._parse_unhandled_input( fsm, ev )

func _on_animation_finished( fsm, ani_name ):
  return ._on_animation_finished( fsm, ani_name )
