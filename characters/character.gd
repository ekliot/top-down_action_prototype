# character.gd

extends KinematicBody2D

export (Vector2) var ACCEL = Vector2( 40, 30 )
export (float) var MAX_SPEED = 250

onready var fsm = $StateMachine
var velocity = Vector2( 0.0, 0.0 )
var look_dir = Vector2( 0.0, 0.0 )

# ============= #
# OVERRIDEABLES #
# ============= #

# ========= #
# UTILITIES #
# ========= #

# update the velocity based on a NORMALIZED direction
func set_velocity( dir ):
  # TODO this ought to grab the world's "floor" friction
  # var friction = get_parent().floor.friction
  var friction = 0.1

  if get_slide_count() > 0:
    # this is naive, and will not select for "real" walls, and will
    # be affected by EVERY collision object
    # TODO think of a way to make this more... feel-goody
    for i in get_slide_count():
      # print( "wall %d // %f" % [ i, get_slide_collision( i ).collider.friction ] )
      friction += get_slide_collision( i ).collider.friction

  velocity += ACCEL * dir

  var max_x = MAX_SPEED * abs( dir.x )
  var max_y = MAX_SPEED * abs( dir.y )

  if dir.y == 0:
    velocity.y = lerp( velocity.y, 0.0, friction )
  else:
    velocity.y = min( max( velocity.y, -max_y ), max_y )

  if dir.x == 0:
    velocity.x = lerp( velocity.x, 0.0, friction )
  else:
    velocity.x = min( max( velocity.x, -max_x ), max_x )

  velocity = move_and_slide( velocity )
