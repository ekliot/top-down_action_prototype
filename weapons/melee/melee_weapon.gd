extends '../weapon.gd'

onready var atk_area = $MeleeAttack

# ======== #
# PRIVATES #
# ======== #

func _ready():
  # connect to atk_area signals
  atk_area.connect( 'hit_target', self, '_hit_target' )

func _init_arc():
  atk_area.set_area( atk_data.attack.dist, atk_data.attack.arc )
  atk_area.set_arc()

# =========== #
# CORE PUBLIC #
# =========== #

func attack_start( dir ):
  atk_area.enable()
  .attack_start( dir )

func attack_end():
  atk_area.disable()
  .attack_end()

# =============== #
# SIGNAL HANDLING #
# =============== #

func _on_aim_update( old_dir, new_dir ):
  atk_area.aim_at_dir( new_dir )

func _on_position_update( old_pos, new_pos ):
  atk_area.aim_from( new_pos )
