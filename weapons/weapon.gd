extends Node

signal weapon_hit

var ID = '_'

var atk_data = {}

var wielder = null
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
  if ignore and not ignoring.has( character ):
    ignoring.push_back( character )

func attack_start( dir ):
  pass

func attack_end():
  pass

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
