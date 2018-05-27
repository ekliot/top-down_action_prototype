# character.gd

extends KinematicBody2D

export (float) var MAX_SPEED = 250
export (Vector2) var ACCEL = Vector2( 40, 30 )

onready var fsm = $StateMachine
var velocity = Vector2( 0.0, 0.0 )
var look_dir = Vector2( 0.0, 0.0 )

# ============= #
# OVERRIDEABLES #
# ============= #

# ============ #
# CORE METHODS #
# ============ #

func move_me( vel=velocity ):
  velocity = move_and_slide( vel )

# ============== #
# HELPER METHODS #
# ============== #

func get_velocity():
  return velocity

func get_velocity_flat():
  return velocity.abs().floor()

# gets the friction applied to the KB at this moment in time
func get_friction():
  # TODO grab friction from the tile currently stood on (e.g. wood vs ice vs tar)
  var friction = get_node( '../Floor' ).get_collision_friction()

  if get_slide_count() > 0:
    # this is naive, and will not select for "real" walls, and will
    # be affected by EVERY collision object
    # TODO think of a way to make this more... feel-goody
    for i in get_slide_count():
      # print( "wall %d // %f" % [ i, get_slide_collision( i ).collider.friction ] )
      friction += get_slide_collision( i ).collider.friction

  return friction
