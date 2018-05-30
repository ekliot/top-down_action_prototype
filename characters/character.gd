# character.gd

extends KinematicBody2D

onready var fsm = $StateMachine
var velocity = Vector2( 0.0, 0.0 )
var look_dir = Vector2( 0.0, 0.0 )

# ============= #
# OVERRIDEABLES #
# ============= #

# ============ #
# CORE METHODS #
# ============ #

func apply_velocity( vel=velocity ):
  # print( 'applying velocity... ', vel )
  velocity = move_and_slide( vel )
  # print( '  > velocity now ', velocity )

func push_me( accel, dir ):
  # print( 'pushing by... ', accel, ' and ', dir )
  velocity = move_and_slide( velocity + accel * dir )
  # print( '  > velocity now ', velocity )

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

func get_look_dir():
  return look_dir

func get_attack_data():
  return $Weapon.get_attack_data()
