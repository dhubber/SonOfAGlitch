extends "res://Scenes/David/SpeedRunnerBase.gd"


onready var navigation = get_tree().get_root().find_node("Navigation2D", true, false)

var current_destination = Vector2()

var path = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func find_possible_destinations():
	pass

func find_new_path():
	pass
