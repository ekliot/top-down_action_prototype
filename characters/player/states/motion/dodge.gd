extends '../motion.gd'

export (float) var FORCE = 600
export (float) var DURATION = 0.1

var elapsed = 0
var rolled = false

func _init():
  ID = 'dodge'

func _on_enter( fsm ):
  if not rolled:
    # start animation
    pass
  return ._on_enter( fsm )

func _on_leave( fsm ):
  elapsed = 0
  fsm.host.apply_velocity( fsm.host.get_velocity() * 0.2 )
  return ._on_leave( fsm )

func _update( fsm, delta ):
  return ._update( fsm, delta )

func _physics_update( fsm, delta ):
  elapsed += delta

  if elapsed >= DURATION:
    # QUESTION does dodging need recovery time?
    # return 'recover'
    return fsm.OP_POP

  var dir = move_dir()

  if dir == Vector2( 0.0, 0.0 ):
    # TEMP uncomment once look dir is implemented
    # dir = -1 * fsm.host.look_dir()
    dir = Vector2( 0.0, 1.0 )

  # TODO undecided whether dodging ought to be an application of force,
  # or a flat velocity
  # fsm.host.push_me( FORCE, dir )
  fsm.host.apply_velocity( dir * FORCE * 5 )

  return ._physics_update( fsm, delta )

func _on_animation_finished( fsm, ani_name ):
  return ._on_animation_finished( fsm, ani_name )
