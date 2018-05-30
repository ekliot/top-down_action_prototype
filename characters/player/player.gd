# player.gd

extends '../character.gd'

# ========= #
# OVERRIDES #
# ========= #

func _ready():
  # ACCEL = Vector2( 40, 30 )
  # MAX_SPEED = 500
  fsm.enter( 'idle' )

func _process( delta ):
  pass

# ==== #
# CORE #
# ==== #

func look_dir():
  # look_dir = mouse pos - player pos
  return look_dir
