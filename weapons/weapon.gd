extends Node

signal weapon_hit

var ID = '_'

var atk_data = {}

func _ready():
  # connect to $AttackArea signals
  pass

func _init_data():
  if ID != '_':
    var file = File.new()
    file.open( 'res://weapons/data/' + ID + '.json', file.READ )
    var txt = file.get_as_text()
    var json = parse_json( txt )
    print( 'res://weapons/data/' + ID + '.json', file )
    print( txt )
    print( json )
    print( typeof( json ) )
    if typeof( json ) == TYPE_DICTIONARY:
      atk_data = json
      atk_data['weapon'] = self
      print( atk_data )
    else:
      print( 'weapon.gd // JSON file for ', ID, 'was not a dictionary' )

func _init_arc():
  $AttackArea.set_area( atk_data.attack.dist, atk_data.attack.arc )
  $AttackArea.set_arc()

func attack_start( dir ):
  $AttackArea.enable()

func attack_end():
  $AttackArea.disable()

func _on_aim_update( old_dir, new_dir ):
  $AttackArea.aim_at_dir( new_dir )

func _on_position_update( old_pos, new_pos ):
  $AttackArea.aim_from( new_pos )

func get_attack_data():
  return atk_data

func get_attack_position():
  print( get_tree() )
  return Vector2( 100, 100 )
