# player.gd

extends '../character.gd'

# ========= #
# OVERRIDES #
# ========= #

func _ready():
  # ACCEL = Vector2( 40, 30 )
  # MAX_SPEED = 500
  fsm.start( 'idle' )

func _process( delta ):
  update_look_dir()

func update_look_dir():
  var dir = get_viewport().get_mouse_position() - get_position()
  set_look_dir( dir.normalized() )

func get_active_weapon():
  # TEMP
  return $Weapon
