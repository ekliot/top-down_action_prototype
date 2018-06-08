# ============================================================================ #
# Undecided whether rolling ought to be implemented.
# I'm sticking with just dodging for now
# ============================================================================ #

# extends '../player_state.gd'
#
# export (float) var FORCE = 200
# export (float) var DURATION = 0.2
#
# var elapsed = 0
#
# func _init():
#   ID = 'roll'
#
# func _on_enter( fsm, last_state=null, state_data={} ):
#   return ._on_enter( fsm, last_state )
#
# func _on_leave( fsm ):
#   elapsed = 0
#   return ._on_leave( fsm )
#
# func _update( fsm, delta ):
#   return ._update( fsm, delta )
#
# func _physics_update( fsm, delta ):
#   elapsed += delta
#
#   if elapsed > DURATION:
#     return fsm.OP_POP
#
#   var dir = move_dir()
#
#   if dir == Vector2( 0.0, 0.0 ):
#     # dir = -1 * fsm.host.look_dir()
#     dir = Vector2( 0.0, 1.0 )
#
#   # fsm.host.push_me( FORCE, dir )
#   fsm.host.apply_velocity( dir * FORCE * 6 )
#
#   return ._physics_update( fsm, delta )
#
# func _on_animation_finished( fsm, ani_name ):
#   return ._on_animation_finished( fsm, ani_name )
