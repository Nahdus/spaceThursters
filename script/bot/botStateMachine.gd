extends StateMachine


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	transistion_table = {
		"idle":["walk"],
		"walk":["idle"]
	}
	setTarget(get_parent())
	setCurrentState("idle",{})
#	target.get_node('body').get_node("AnimationTree").start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	current_state.state_process(delta)
	pass
