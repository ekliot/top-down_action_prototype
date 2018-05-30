extends './weapon.gd'

func _init():
  ID = 'club'

  DAMAGE_MIN = 1
  DAMAGE_MAX = 3
  ATTACK_RANGE = 10.0
  ATTACK_DEGREES = 90.0

  CHARGE_SPEED = 0.15
  ATTACK_SPEED = 0.05
  RECOVER_SPEED = 0.1
