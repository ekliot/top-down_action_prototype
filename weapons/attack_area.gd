extends Area2D

var reach = 0.0
var arc = 0.0
var center = Vector2( 0.0, 0.0 )
var look_at = Vector2( 1.0, 0.0 )

var arc_path = PoolVector2Array()
var colors = PoolColorArray([Color( 1.0, 1.0, 1.0 )])

func _ready():
  disable()

func _draw():
  set_arc()
  draw_polygon( arc_path, colors )

func set_area( _reach, _arc ):
  reach = _reach
  arc = _arc

func set_arc():
  var nb_points = reach

  arc_path = PoolVector2Array()
  arc_path.push_back( center )

  var ang_from = rad2deg( look_at.angle() ) + ( arc / 2 )

  for i in range( nb_points + 1 ):
    var angle = deg2rad( ang_from + i * ( arc ) / nb_points - 90 )
    var d_center = center + reach * Vector2( cos( angle ), sin( angle ) ) * 10
    # var d_center = center + reach * Vector2( cos( angle ), sin( angle ) )
    arc_path.push_back( d_center )

func aim_from( pos ):
  center = pos
  update()

# takes a NORMALIZED direction vector
func aim_at_dir( dir ):
  look_at = dir
  update()

## takes a NORMALIZED direction vector
#func dir_to_angle( dir ):
#  return atan2( dir.y, dir.x )

func enable():
  $Arc.set_disabled( false )
  show()

func disable():
  $Arc.set_disabled( true )
  hide()

func is_enabled():
  return not $Arc.is_disabled()
