extends Node

signal weapon_hit

var ID = '_'

var atk_data = {}
onready var atk_area = $AttackArea

func _ready():
  # connect to atk_area signals
  atk_area.connect( 'body_entered', self, 'hit_target' )
  pass

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

func attack_start( dir ):
  atk_area.enable()

func attack_end():
  print( atk_area.get_overlapping_bodies() )
  print( atk_area.get_collision_layer() )
  print( atk_area.get_collision_mask() )
  print( atk_area.is_enabled() )
  atk_area.disable()

func hit_target( target ):
  print( 'oof' )
  print( 'hit target // ', target )

func _on_aim_update( old_dir, new_dir ):
  atk_area.aim_at_dir( new_dir )

func _on_position_update( old_pos, new_pos ):
  atk_area.aim_from( new_pos )

func get_attack_data():
  return atk_data

func get_attack_position():
  print( get_tree() )
  return Vector2( 100, 100 )
