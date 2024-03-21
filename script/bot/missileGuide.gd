extends Node2D

onready var tangent:Line2D = get_node("line")

export(NodePath) var parabola_node_path
export (NodePath) var ship_node_path
onready var ship_node = get_node(ship_node_path)
onready var parabola = get_node(parabola_node_path)
onready var gun = get_parent().get_parent().get_parent()

onready var tip = get_parent()
onready var turret_sprite = get_parent().get_parent()
var parabola_Velocity = 50
var parabola_gravity = 9.8
var t = 0
var update_time = 0.01
var slope_of_tangent = 0
var parabola_phase = 0
var parabola_scale = 0
var parabola_width =0
var parabola_height = 0
var tangentrray = []
var parabolaarray = []
var launched = false
var coolDownTime = 0.5
var coolCount = 0

func _ready():
	print(get_parent().get_parent().get_parent().name)
	pass # Replace with function body.


func draw_parabola():
	parabolaarray =[]
	parabola.clear_points()
#	print(tip.position.x*cos(gun.rotation))
	for x_cord in range(tip.position.x*cos(gun.rotation),tip.position.x*cos(gun.rotation)+500,2):
#	for x_cord in range(self.position.y-500,tip.position.x*cos(-gun.rotation)+500,2):
		var point_ycord = (parabola_scale*pow((x_cord-parabola_phase),2)-parabola_height) 
		parabolaarray.append(Vector2(x_cord,point_ycord))
	for each in parabolaarray:
		parabola.add_point(each)



func draw_line_to_cursor():
	tangent.clear_points()
	tangentrray = []
	if turret_sprite.flip_h==true:
		self.set_position(Vector2(-28,0))
	if turret_sprite.flip_h==false:
		self.set_position(Vector2(0,0))
#	tangentrray.append(Vector2(tip.position.x*cos(-gun.rotation),tip.position.x*sin(-gun.rotation)))
	tangentrray.append(tip.position)
	tangentrray.append(get_local_mouse_position())
		
	for point in tangentrray:
		tangent.add_point(point)
		
func calculate_parabola_properties():
#	slope_of_tangent = (tip.position.y-tangentrray[1].x*sin(gun.rotation))/(tangentrray[1].x-tangentrray[0].x)
	slope_of_tangent = atan(-gun.rotation)
	
	parabola_width = 2*pow(parabola_Velocity,2)*cos(-gun.rotation)*sin(-gun.rotation)/parabola_gravity
	parabola_height = slope_of_tangent*tip.position.x*cos(-gun.rotation) + parabola_scale*pow((tip.position.x*cos(-gun.rotation)-parabola_phase),2)
	parabola_phase = (tip.position.x*cos(-gun.rotation)+parabola_width+tip.position.x)/2
	parabola_scale = slope_of_tangent/(parabola_phase-tip.position.x*cos(-gun.rotation))
	pass
func _process(delta):
	t+=delta
	coolCount+=delta
#	if get_parent().get_parent().get_node("Sprite").flip_h == true:
#		print('flipped')
#	self.set_position(get_parent().position)
	if t>update_time:
		t=0
#		draw_parabola()
		draw_line_to_cursor()
		calculate_parabola_properties()
		draw_parabola()
		
	if coolCount > coolDownTime:
		coolCount = 0
		if launched == true:
			launched = false
	
	if Input.is_action_pressed("launch"):
		if launched == false:
			launched = true
			coolCount = 0
			ship_node.launch(
				{"angle":-gun.rotation,
				"speed":self.parabola_Velocity,
				"gravity":self.parabola_gravity,
				"initial_position":self.global_position
				})
		pass
	pass
