extends "../player_state.gd"

# data must match Weapon.atk_data
var attack_data = {}
var elapsed = 0
var ready = false

# ========= #
# OVERRIDES #
# ========= #

func _init():
  ID = 'attack'

func _on_enter( fsm, last_state, state_data ):
  ready = last_state == 'ready'
  elapsed = 0

  if ready:
    attack_start( fsm.host )
  else:
    attack_data = state_data

  return ._on_enter( fsm, last_state )

func _on_leave( fsm ):
  fsm.set_state_data( ID, {} )
  # clear our data if our attack has completed
  #   (ready is true only once the attack has started, and if
  #   we leave for any reason the attack is annulled)
  if ready:
    ready = false
    attack_data = {}

  return ._on_leave( fsm )

func _update( fsm, delta ):
  if not ready:
    var ready_data = { 'duration': attack_data.speed.ready, 'next_state': ID }
    fsm.set_state_data( 'ready', ready_data )
    return 'ready'

  return ._update( fsm, delta )

func _physics_update( fsm, delta ):
  if not ready:
    return null

  elapsed += delta

  if elapsed >= attack_data.speed.attack:
    # set the 'recover' data
    attack_end()
    fsm.set_state_data( 'recover', { 'duration': attack_data.speed.recover } )
    return 'recover'

  var dir = fsm.host.get_look_dir()
  fsm.host.apply_velocity( dir * 100 )

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

func attack_start( player ):
  var dir = player.get_look_dir()
  attack_data.weapon.attack_start( dir )
  player.animate( ID + dir_as_str( dir ) )

func attack_end():
  attack_data.weapon.attack_end()
