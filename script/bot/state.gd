extends Node

class_name State

onready var state_name 
onready var stateMachine:StateMachine  = get_parent()
onready var target = stateMachine.target


func set_target(t):
	target = t

func state_process(_delta):
	pass


func enter(arg):
	print("Entered "+state_name)
	pass

func exit():
	print("Exited "+state_name)
	pass


	
