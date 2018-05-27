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

# update the velocity based on a NORMALIZED direction and any relevant multipliers
func set_velocity( dir, max_mult=1.0, accel_mult=1.0 ):
  # TODO grab friction from the tile currently stood on (e.g. wood vs ice vs tar)
  var friction = get_node( '../Floor' ).get_collision_friction()

  if get_slide_count() > 0:
    # this is naive, and will not select for "real" walls, and will
    # be affected by EVERY collision object
    # TODO think of a way to make this more... feel-goody
    for i in get_slide_count():
      # print( "wall %d // %f" % [ i, get_slide_collision( i ).collider.friction ] )
      friction += get_slide_collision( i ).collider.friction

  velocity += ACCEL * accel_mult * dir

  var max_x = MAX_SPEED * max_mult * abs( dir.x )
  var max_y = MAX_SPEED * max_mult * abs( dir.y )

  if dir.y == 0:
    velocity.y = lerp( velocity.y, 0.0, friction )
  else:
    velocity.y = min( max( velocity.y, -max_y ), max_y )

  if dir.x == 0:
    velocity.x = lerp( velocity.x, 0.0, friction )
  else:
    velocity.x = min( max( velocity.x, -max_x ), max_x )

  velocity = move_and_slide( velocity )
