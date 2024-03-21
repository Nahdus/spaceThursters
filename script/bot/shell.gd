extends KinematicBody2D

var angle
var speed
var gravity
var initial_position
var y_speed 
var x_speed

var explosion  = load("res://scene/explode.tscn")
func _ready():
	self.position = initial_position
	

func launch(initialState):
	angle = initialState['angle']
	speed = initialState['speed']
	y_speed = speed*sin(-angle)
	x_speed = speed*cos(-angle)
	gravity = initialState['gravity']
	print(gravity)
	initial_position = initialState['initial_position']

func _process(delta):
	var shell_velocity = move_and_slide(Vector2(x_speed,y_speed))
	x_speed = shell_velocity.x
	y_speed+=delta*gravity

	self.set_rotation(asin(clamp(y_speed/speed,-1,1)))
	if is_on_floor():
		print("on floor")
#	print(self.position.y)
	if self.position.y>570:
		var instance = explosion.instance()
		instance.emitting = true
		instance.set_position(self.position)
		get_parent().add_child(instance)
		self.queue_free()
	
		
		
	
	
#	var point_ycord = (m*pow((point_xcord-p),2)-h) +launch_point.x*sin(angle)
#	self.set_position(Vector2(point_xcord,point_ycord))
	
