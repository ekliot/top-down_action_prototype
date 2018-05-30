extends "res://util/states/state.gd"

var attack_data = {}
var charging = false

var elapsed = 0

func _init():
  ID = 'attack'

func _on_enter( fsm ):
  # get attack data from the fsm
  attack_data = fsm.get_state_data( ID )

  # set the 'charge' data
  fsm.set_state_data( 'charge', attack_data )

  return ._on_enter( fsm )

func _on_leave( fsm ):
  fsm.set_state_data( 'attack', {} )
  elapsed = 0

  if not charging:
    attack_data = {}

  return ._on_leave( fsm )

func _update( fsm, delta ):
  return ._update( fsm, delta )

func _physics_update( fsm, delta ):
  if elapsed >= attack_data.speed.attack:
    # set the 'recover' data
    fsm.set_state_data( 'recover', attack_data )
    return 'recover'

  # put damage box into the worlda
  var dir = fsm.host.get_look_dir()
  attack_data.weapon.attack( dir )

  return ._physics_update( fsm, delta )

func _parse_input( fsm, ev ):
  return ._parse_input( fsm, ev )

func _parse_unhandled_input( fsm, ev ):
  return ._parse_unhandled_input( fsm, ev )

func _on_animation_finished( fsm, ani_name ):
  return ._on_animation_finished( fsm, ani_name )
