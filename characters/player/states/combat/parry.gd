extends "res://util/states/state.gd"

func _init():
  ID = 'parry'

func _on_enter( fsm, last_state=null, state_data={} ):
  return ._on_enter( fsm, last_state )

func _on_leave( fsm ):
  return ._on_leave( fsm )

func _update( fsm, delta ):
  return ._update( fsm, delta )

func _physics_update( fsm, delta ):
  return ._physics_update( fsm, delta )

func _parse_input( fsm, ev ):
  return ._parse_input( fsm, ev )

func _parse_unhandled_input( fsm, ev ):
  return ._parse_unhandled_input( fsm, ev )

func _on_animation_finished( fsm, ani_name ):
  return ._on_animation_finished( fsm, ani_name )
