extends '../motion.gd'

# ==== #
# VARS #
# ==== #

#= EXPORTS

export (float) var MAX_VEL = Vector2( 250, 240 )
export (Vector2) var ACCEL = Vector2( 40, 30 )

export (float) var SPRINT_MAX   = 1.5
export (float) var SPRINT_ACCEL = 1.5

#= LOCALS

var sprinting = false

# ============== #
# NODE OVERRIDES #
# ============== #

func _init():
  ID = 'move'

# ========= #
# STATE BIZ #
# ========= #

func _on_enter( fsm ):
  check_sprint()
  # play movement animation
  return ._on_enter( fsm )

func _on_leave( fsm ):
  sprinting = false
  return ._on_leave( fsm )

func _physics_update( fsm, delta ):
  var interrupt = check_interrupts()

  if interrupt:
    return interrupt

  # update my velocity based on where I want to move
  check_sprint()
  move_step( fsm )

  # if we've stopped moving (including hitting a wall), return to our last state (idle)
  if fsm.host.get_velocity_flat() == Vector2( 0.0, 0.0 ):
    return fsm.OP_POP

  return ._physics_update( fsm, delta )

func _on_animation_finished( fsm, ani_name ):
  return ._on_animation_finished( fsm, ani_name )

# ============ #
# CORE METHODS #
# ============ #

func move_step( fsm ):
  var player = fsm.host
  var _vel = player.get_velocity()
  var frict = player.get_friction()

  var dir = move_dir()
  var max_v = MAX_VEL * ( 1 + int(sprinting) * (SPRINT_MAX-1) )
  var accel = ACCEL * ( 1 + int(sprinting) * (SPRINT_ACCEL-1) )

  _vel = update_velocity( _vel, accel, dir )
  _vel = cap_velocity( _vel, max_v )

  if dir.x == 0:
    _vel.x = apply_friction_flt( _vel.x, frict )
  if dir.y == 0:
    _vel.y = apply_friction_flt( _vel.y, frict )

  player.move_me( _vel )

# ============== #
# HELPER METHODS #
# ============== #

func check_sprint():
  sprinting = Input.is_action_pressed( 'sprint' )
  return sprinting
