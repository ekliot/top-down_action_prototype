extends Node

signal weapon_hit

var ID = '_'

var atk_data = {}

var wielder = null
var friendly_fire = false
# Bodies to ignore when damaging
var ignoring = []

func _init_data():
  if ID != '_':
    var file = File.new()
    file.open( 'res://weapons/data/' + ID + '.json', file.READ )
    var txt = file.get_as_text()
    var json = parse_json( txt )
    if typeof( json ) == TYPE_DICTIONARY:
      atk_data = json
      atk_data['weapon'] = self
    else:
      print( 'weapon.gd // JSON file for ', ID, ' was not a dictionary' )

# =========== #
# CORE PUBLIC #
# =========== #

func set_wielder( character, ignore=true ):
  wielder = character

func attack_start( dir ):
  pass

func attack_end():
  pass

# ============ #
# CORE PRIVATE #
# ============ #

func _hit_target( target ):
  # TODO instead of an ignoring array, use Node groups for friendlies, and check vs friendly fire enabled
  if target.has_method( 'take_damage' ) and target != wielder:
    print( wielder, ' hit ', target, ' with ', ID )
    # TEMP have a calc_damage method
    target.take_damage( wielder, atk_data.damage.min, atk_data.type )

# =============== #
# SIGNAL HANDLING #
# =============== #

func _on_aim_update( old_dir, new_dir ):
  pass

func _on_position_update( old_pos, new_pos ):
  pass

# ======= #
# GETTERS #
# ======= #

func get_attack_data():
  return atk_data
