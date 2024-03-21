extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var time= 0

onready var gun =  get_node("gun")
onready var dropPointSprite = get_node("floorTarget")
var velocityOfProjectile = 50
var garvity = 9.8

var dropPoint = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.z
func _process(delta):
	var aim = get_global_mouse_position()
	time+=delta
	if get_node("Sprite").flip_h:
		var gun_rotation = clamp(-atan((self.global_position.y - aim.y)/clamp((self.global_position.x - aim.x),0.1,999)),-PI/3,PI/3)
		gun.set_rotation(-gun_rotation)
		gun.get_node("Sprite").set_offset(Vector2(-16,0))
		gun.get_node("Sprite").flip_h = true
		dropPoint = 2*(pow(velocityOfProjectile,2)/garvity)*sin(-gun.rotation)*cos(-gun.rotation)-32
	else:
		gun.set_rotation(clamp(-atan((self.global_position.y - aim.y)/clamp((aim.x -self.global_position.x),0.1,999)),-PI/3,PI/3))
		gun.get_node("Sprite").set_offset(Vector2(16,0))
		gun.get_node("Sprite").flip_h = false
		dropPoint = 2*(pow(velocityOfProjectile,2)/garvity)*sin(-gun.rotation)*cos(-gun.rotation)+32
#	print(-gun.rotation_degrees)
	dropPointSprite.set_position(Vector2(gun.get_node("Sprite/tip").position.x+dropPoint,position.y))
#	gun.set_rotation(clamp(-atan((self.global_position.y - aim.y)/clamp((aim.x -self.global_position.x),0.1,999)),-PI/4,PI/4))
#	if time>10:
#		print(self.position)
#		print(aim)
#		print(atan((aim.x -self.position.x)/(aim.y-self.position.y)))
#		time =0
#	gun.set_rotation_degrees(45)
	
	pass
