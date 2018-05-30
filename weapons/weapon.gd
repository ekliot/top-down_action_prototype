extends Node

var ID = '_'

export (float) var DAMAGE_MIN = 0.0
export (float) var DAMAGE_MAX = 0.0
export (float) var ATTACK_RANGE = 0.0
export (float) var ATTACK_DEGREES = 0.0

export (float) var CHARGE_SPEED = 0.0
export (float) var ATTACK_SPEED = 0.0
export (float) var RECOVER_SPEED = 0.0

var atk_data = {}

func _ready():
  $AttackArea.RANGE = ATTACK_RANGE
  $AttackArea.DEGREES = ATTACK_DEGREES

  $AttackArea.set_arc()
  $AttackArea.disable()

  atk_data = {
    weapon: self,
    attack: { dist: ATTACK_RANGE, degrees: ATTACK_DEGREES },
    speed: { charge: CHARGE_SPEED, attack: ATTACK_SPEED, recover: RECOVER_SPEED }
  }

func attack_start( dir ):
  $AttackArea.look_at( $Parent.get_look_dir )
  $AttackArea.enable()

func attack_end():
  $AttackArea.disable()

func get_attack_data():
  return atk_data
