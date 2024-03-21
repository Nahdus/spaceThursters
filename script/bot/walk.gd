extends State

var dir
var peakVelocityTime = 2 #sec
var currentVelocity = 0
export var maxSpeed = 300
export var timeToVelocityZero = 1
var speed = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	state_name = "walk"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
func enter(arg):
	dir = arg["direction"]
	if dir==Vector2(1,0):
		stateMachine.target.get_node('body').get_node("AnimationTree")["parameters/playback"].travel("moveRight")
	if dir==Vector2(-1,0):
		stateMachine.target.get_node('body').get_node("AnimationTree")["parameters/playback"].travel("moveLeft")
	print("Entered "+state_name)
	currentVelocity = 0
	pass
	
func exit():
	print("exiting walk")
	
	currentVelocity = 0

func get_dir():
#	if Input.is_action_pressed("right"):
#		return Vector2(1,0)
#	if Input.is_action_pressed("left"):
#		return Vector2(-1,0)
	return dir

func get_current_speed(currentSpeed,delta):
	if (Input.is_action_pressed("right") and dir == Vector2(1,0)) or (Input.is_action_pressed("left") and dir == Vector2(-1,0)):
		currentSpeed += (maxSpeed/peakVelocityTime)*delta
	else:
		currentSpeed -= (currentSpeed/timeToVelocityZero)*delta
	if currentSpeed>maxSpeed:
		return maxSpeed
	if currentSpeed < 0.5:
		return 0
	return currentSpeed

func state_process(delta):
	dir = get_dir()
	if dir == Vector2(1,0):
		currentVelocity = get_current_speed(currentVelocity,delta)
		stateMachine.target.position.x+=delta*currentVelocity
#		print(stateMachine.target)
		
		if currentVelocity == 0:
			print(currentVelocity)
			stateMachine.transistionToState("idle",{})
	elif dir == Vector2(-1,0):
		currentVelocity = get_current_speed(currentVelocity,delta)
		stateMachine.target.position.x-=delta*currentVelocity
#		print(stateMachine.target)
		
		if currentVelocity == 0:
			print(currentVelocity)
			stateMachine.transistionToState("idle",{})	
	
	
	
