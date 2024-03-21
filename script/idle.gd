extends State


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	state_name = "idle"
	pass # Replace with function body.

func enter(arg):
	stateMachine.target.get_node('body').get_node("AnimationTree")["parameters/playback"].travel("idle")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func transistion():
	if Input.is_action_pressed("right") :
		stateMachine.transistionToState("walk",{"direction":Vector2(1,0)})
	if Input.is_action_pressed("left"):
		stateMachine.transistionToState("walk",{"direction":Vector2(-1,0)})

func state_process(delta):
	transistion()
	pass
	
