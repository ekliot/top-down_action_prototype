extends "res://util/states/state.gd"

# data must match Weapon.atk_data
var attack_data = {}
var ready = false

var elapsed = 0

# ========= #
# OVERRIDES #
# ========= #

func _init():
  ID = 'attack'

func _on_enter( fsm, last_state ):
  ready = last_state == 'ready'

  if ready:
    attack_start( fsm.host.get_look_dir() )
  else:
    attack_data = fsm.get_state_data( ID )
    var ready_data = { 'duration': attack_data.speed.ready }
    fsm.set_state_data( 'ready', ready_data )

  return ._on_enter( fsm, last_state )

func _on_leave( fsm ):
  fsm.set_state_data( ID, {} )

  # clear our data if our attack has completed
  #   (ready is true only once the attack has started, and if
  #   we leave for any reason the attack is annulled)
  if ready:
    attack_end()

  return ._on_leave( fsm )

func _update( fsm, delta ):
  if not ready:
    return 'ready'
  return ._update( fsm, delta )

func _physics_update( fsm, delta ):
  if not ready:
    return null

  elapsed += delta

  print( elapsed )

  if elapsed >= attack_data.speed.attack:
    # set the 'recover' data
    fsm.set_state_data( 'recover', attack_data )
    return 'recover'

  return ._physics_update( fsm, delta )

func _parse_input( fsm, ev ):
  return ._parse_input( fsm, ev )

func _parse_unhandled_input( fsm, ev ):
  return ._parse_unhandled_input( fsm, ev )

func _on_animation_finished( fsm, ani_name ):
  return ._on_animation_finished( fsm, ani_name )

# ==== #
# CORE #
# ==== #

func attack_start( dir ):
  attack_data.weapon.attack_start( dir )

func attack_end():
  attack_data.weapon.attack_end()
  ready = false
  elapsed = 0
  attack_data = {}
