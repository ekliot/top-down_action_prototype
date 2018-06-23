# character.gd

extends KinematicBody2D

signal update_look_dir # old_dir, new_dir
signal update_position # old_pos, new_pos

signal recover_health # amt, new_hp, max_hp
signal take_damage # amt, new_hp, max_hp

export (int) var MAX_HEALTH = 10

export (Vector2) var MAX_VEL = Vector2( 250, 240 )
export (Vector2) var ACCEL = Vector2( 40, 30 )

onready var fsm = $StateMachine
var velocity = Vector2( 0.0, 0.0 )
var look_dir = Vector2( 0.0, 0.0 )

onready var current_health = MAX_HEALTH
onready var hp_bar = $HealthBar

# ============= #
# OVERRIDEABLES #
# ============= #

func _ready():
  emit_signal( 'update_position', Vector2( 0, 0 ), get_position() )

  hp_bar.set_max_hp( MAX_HEALTH )
  hp_bar.fill_hp()

  # print( 'character.gd // ', get_children() )
  for c in get_children():
    if c.has_method( 'set_wielder' ):
      c.set_wielder( self )

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

func animate( anim_name ):
  # TODO
  return

func take_damage( from, amt, type=null ):
  current_health -= amt
  # TODO check vs damage type and source
  emit_signal( 'take_damage', from, amt, type )

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
    # TODO think of a way to make this more elegant
    for i in get_slide_count():
      # print( "wall %d // %f" % [ i, get_slide_collision( i ).collider.friction ] )
      if get_slide_collision( i ).collider.has_method( 'get_friction' ):
        friction += get_slide_collision( i ).collider.get_friction()

  return friction

func set_look_dir( dir ):
  if dir != look_dir:
    emit_signal( 'update_look_dir', look_dir, dir )
    look_dir = dir

func get_look_dir():
  return look_dir

func get_move_data():
  return { 'max_vel': MAX_VEL, 'accel': ACCEL,
           'cur_vel': get_velocity(),
           'friction': get_friction() }

func get_attack_data():
  return $Weapon.get_attack_data()
