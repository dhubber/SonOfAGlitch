extends Node2D

onready var navigation2d : Navigation2D = $Navigation2D


func _ready():
	pass


func find_path_to_destination(current_position, destination):
	if navigation2d != null:
		print("Finding path : ", current_position, destination)
		var path = navigation2d.get_simple_path(current_position, destination)
		return path
	else:
		return null
