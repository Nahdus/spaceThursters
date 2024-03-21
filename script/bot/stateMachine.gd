extends Node
class_name StateMachine


var target
var transistion_table
var current_state


func setTransistionTable(table):
	transistion_table = table

func setTarget(t):
	target = t
	

	
func setCurrentState(state,arg):
	current_state = get_node(state)
	current_state.enter(arg)
	
func transistionToState(state,arg):
	if state in transistion_table[current_state.state_name]:
		current_state.exit()
		setCurrentState(state,arg)
		
		
func getCurrentState():
	return current_state
	
func MachineProcess(_delta):
	pass
