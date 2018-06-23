extends '../weapon.gd'

onready var atk_area = $MeleeAttack

# ======== #
# PRIVATES #
# ======== #

func _ready():
  # connect to atk_area signals
  atk_area.connect( 'body_entered', self, '_hit_target' )

func _init_arc():
  atk_area.set_area( atk_data.attack.dist, atk_data.attack.arc )
  atk_area.set_arc()

# =========== #
# CORE PUBLIC #
# =========== #

func attack_start( dir ):
  atk_area.enable()

func attack_end():
  atk_area.disable()

# ============ #
# CORE PRIVATE #
# ============ #

func _hit_target( target ):
  print( target )
  # TODO instead of an ignoring array, use Node groups for friendlies, and check vs friendly fire enabled
  if not ignoring.has( target ) and target.has_method( 'take_damage' ):
    print( 'hit' )
    # TEMP have a calc_damage method
    target.take_damage( wielder, atk_data.damage.min, atk_data.type )

# =============== #
# SIGNAL HANDLING #
# =============== #

func _on_aim_update( old_dir, new_dir ):
  atk_area.aim_at_dir( new_dir )

func _on_position_update( old_pos, new_pos ):
  atk_area.aim_from( new_pos )
