extends Node

signal weapon_hit

var ID = '_'

export (float) var DAMAGE_MIN = 0.0
export (float) var DAMAGE_MAX = 0.0
export (float) var ATTACK_REACH = 0.0
export (float) var ATTACK_ARC = 0.0

export (float) var READY_SPEED = 0.0
export (float) var ATTACK_SPEED = 0.0
export (float) var RECOVER_SPEED = 0.0

var atk_data = {}

func _ready():
  # connect to $AttackArea signals
  pass

func init_data():
  atk_data = {
    'weapon': self,
    'attack': { 'dist': ATTACK_REACH, 'arc': ATTACK_ARC },
    'speed': { 'ready': READY_SPEED, 'attack': ATTACK_SPEED, 'recover': RECOVER_SPEED }
  }

func init_arc():
  $AttackArea.set_area( ATTACK_REACH, ATTACK_ARC )
  $AttackArea.set_arc()

func attack_start( dir ):
  $AttackArea.enable()

func attack_end():
  $AttackArea.disable()

func _on_aim_update( old_dir, new_dir ):
  $AttackArea.aim_at_dir( new_dir )

func _on_position_update( old_pos, new_pos ):
  $AttackArea.aim_from( new_pos )

func get_attack_data():
  return atk_data

func get_attack_position():
  print( get_tree() )
  return Vector2( 100, 100 )
