# health_bar.gd

extends TextureProgress

func fill_hp():
  set_value( get_max() )

func set_max_hp( max_hp ):
  set_max( max_hp )

func set_hp( val ):
  set_value( val )

func take_damage( dmg ):
  set_value( get_value() - dmg )
