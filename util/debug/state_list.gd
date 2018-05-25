extends Panel

# func _on_Player_state_changed( states_stack ):


func _on_StateMachine_state_change():
  var states_names = ''

  var stack = get_parent().get_node( "StateMachine" ).stack

  for state in stack:
    states_names += state.get_name() + '\n'

  $States.text = states_names
