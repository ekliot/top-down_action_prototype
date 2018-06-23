extends '../player_state.gd'

export (float) var FORCE = 800
export (float) var DURATION = 0.06
export (float) var STOP_MULT = 0.2

# var dodge_data = {}
var elapsed = 0
var dir = null

func _init():
  ID = 'dodge'

func _on_enter( fsm, last_state, state_data ):
  elapsed = 0
  dir = move_dir()

  if dir == Vector2( 0.0, 0.0 ):
    dir = -1 * fsm.host.get_look_dir()

  # start animation
  fsm.host.animate( ID + dir_as_str( dir ) )

  return ._on_enter( fsm, last_state )

func _on_leave( fsm ):
  # "hard stop"
  fsm.host.apply_velocity( fsm.host.get_velocity() * STOP_MULT )
  return ._on_leave( fsm )

func _update( fsm, delta ):
  return ._update( fsm, delta )

func _physics_update( fsm, delta ):
  elapsed += delta

  if elapsed >= DURATION:
    # QUESTION does dodging need recovery time?
    # return 'recover'
    return fsm.START_STATE

  # TODO undecided whether dodging ought to be an application of force,
  # or a flat velocity
  # fsm.host.push_me( FORCE, dir )
  fsm.host.apply_velocity( dir * FORCE * 2 )

  return ._physics_update( fsm, delta )

func _on_animation_finished( fsm, ani_name ):
  return ._on_animation_finished( fsm, ani_name )
