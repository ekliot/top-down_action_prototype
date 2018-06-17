extends Node

signal weapon_hit

var ID = '_'

var atk_data = {}
onready var atk_area = $AttackArea

var wielder = null
# Bodies to ignore when damaging
var ignoring = []

# ======== #
# PRIVATES #
# ======== #

func _ready():
  # connect to atk_area signals
  atk_area.connect( 'body_entered', self, '_hit_target' )

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
      print( 'weapon.gd // JSON file for ', ID, 'was not a dictionary' )

func _init_arc():
  atk_area.set_area( atk_data.attack.dist, atk_data.attack.arc )
  atk_area.set_arc()

# =========== #
# PUBLIC CORE #
# =========== #

func set_wielder( character, ignore=true ):
  wielder = character
  if ignore and not ignoring.has( character ):
    ignoring.push_back( character )

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

# ======= #
# GETTERS #
# ======= #

func get_attack_data():
  return atk_data
