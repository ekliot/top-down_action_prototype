extends '../player_state.gd'

func _init():
  ID = 'idle'

func _on_enter( fsm, last_state=null, state_data={} ):
  # set animation to idle
  fsm.host.animate( ID + move_dir_as_str() )
  return ._on_enter( fsm, last_state )

func _on_leave( fsm ):
  return ._on_leave( fsm )

func _update( fsm, delta ):
  return ._update( fsm, delta )

func _physics_update( fsm, delta ):
  if Input.is_action_just_pressed( 'dodge' ):
    return 'dodge'

  if Input.is_action_just_pressed( 'attack' ):
    fsm.set_state_data( 'attack', fsm.host.get_attack_data() )
    return 'attack'

  if move_dir() != Vector2( 0.0, 0.0 ):
    return 'move'

  if fsm.host.get_velocity_flat() != Vector2( 0.0, 0.0 ):
    var player = fsm.host
    var _vel = player.get_velocity()
    var frict = player.get_friction()

    _vel = apply_friction_vec( _vel, frict )

    player.apply_velocity( _vel )

  return ._physics_update( fsm, delta )

func _on_animation_finished( fsm, ani_name ):
  return ._on_animation_finished( fsm, ani_name )
