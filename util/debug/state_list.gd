extends Panel

func _on_StateMachine_state_change( from, to ):
  $States.text = ''
  
  if from:
    $States.text += from
  else:
    $States.text += 'null'
    
  $States.text += ' -> ' + to
