# character.gd

extends KinematicBody2D

signal update_look_dir # old_dir, new_dir
signal update_position # old_pos, new_pos

onready var fsm = $StateMachine
var velocity = Vector2( 0.0, 0.0 )
var look_dir = Vector2( 0.0, 0.0 )

# ============= #
# OVERRIDEABLES #
# ============= #

func _ready():
  emit_signal( 'update_position', Vector2( 0, 0 ), get_position() )  

# ============ #
# CORE METHODS #
# ============ #

func apply_velocity( vel=velocity ):
  var _pos = get_position()
  velocity = move_and_slide( vel )
  if _pos != get_position():
    emit_signal( 'update_position', _pos, get_position() )

func push_me( accel, dir ):
  var _pos = get_position()
  velocity = move_and_slide( velocity + accel * dir )
  if _pos != get_position():
    emit_signal( 'update_position', _pos, get_position() )

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

func set_look_dir( dir ):
  if dir != look_dir:
    emit_signal( 'update_look_dir', look_dir, dir )
    look_dir = dir

func get_look_dir():
  return look_dir

func get_attack_data():
  return $Weapon.get_attack_data()
