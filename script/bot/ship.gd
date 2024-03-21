extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var shell_scene = load('res://scene/shell.tscn')
var launch_soundScene = load('res://scene/launchSound.tscn')
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func launch(initialState):
	print(initialState)
	var instance = shell_scene.instance()
	var soundInstance = launch_soundScene.instance()
	add_child(soundInstance)
	soundInstance.play()
	instance.launch(initialState)
	get_parent().add_child(instance)
	get_node("launchSound").play()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
