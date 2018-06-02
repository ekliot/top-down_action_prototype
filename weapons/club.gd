extends './weapon.gd'

func _init():
  ID = 'club'

  DAMAGE_MIN = 1
  DAMAGE_MAX = 3
  ATTACK_REACH = 10.0
  ATTACK_ARC = 90.0

  READY_SPEED = 0.15
  ATTACK_SPEED = 0.05
  RECOVER_SPEED = 0.1

  init_data()
  init_arc()
