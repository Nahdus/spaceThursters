extends Node2D

onready var line:Line2D = get_node("line")
var linePoints:Array = []

var maxPoints = 100
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var t = 0
var draw_time = 0.05
func _ready():
	linePoints = [Vector2(0,0)]
#	draw_parabola()
	pass

# Called when the node enters the scene tree for the first time.
func draw_parabola():
#	print(linePoints)
#	get_global_mouse_position()
#	if len(linePoints)> maxPoints:
#		linePoints.pop_back()
#	linePoints.append(get_global_mouse_position())
	
	for point in linePoints:
		
		line.add_point(point)
	linePoints.append(linePoints[-1]+Vector2(50,10))
#	print(linePoints)
	if len(linePoints)>5:
		linePoints.pop_front()
#	print(linePoints[-1])
#		linePoints.pop_back()
	
func clear_parabola():
	line.clear_points()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t+=delta
	if t> draw_time:
		t=0
		line.clear_points()
		draw_parabola()
	
	pass
