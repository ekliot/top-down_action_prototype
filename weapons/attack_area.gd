extends Area2D

var RANGE = 0.0
var DEGREES = 0.0

var ARC_PTS = PoolVector2Array()

var dir = Vector2( 1.0, 0.0 )

func set_arc():
  var nb_points = 32
  var colors = PoolColorArray( [ Color( 1.0, 1.0, 1.0 ) ] )

  var center = Vector2( 0.0, 0.0 )

  ARC_PTS.push_back( center )

  var ang_from = -DEGREES / 2

  for i in range( nb_points + 1 ):
    var angle = deg2rad( ang_from + i * ( DEGREES ) / nb_points - 90 )
    var d_center = center + RANGE * Vector2( cos( angle ), sin( angle ) )
    ARC_PTS.push_back( d_center )

  $Arc( ARC_PTS )

func enable():
  $Arc.set_disabled( false )

func disable():
  $Arc.set_disabled( true )
