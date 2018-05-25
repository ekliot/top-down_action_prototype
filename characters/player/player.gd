# player.gd

extends '../character.gd'

# ========= #
# OVERRIDES #
# ========= #

func _init():
  ACCEL = Vector2( 40, 30 )
  MAX_SPEED = 500

func _ready():
  fsm.enter( 'idle' )

func _process( delta ):
  # look_dir = look_dir()
  pass

# ==== #
# CORE #
# ==== #

func look_dir():
  # look_dir = mouse pos - player pos
  return look_dir
