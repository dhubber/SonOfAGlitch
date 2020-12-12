extends "res://Scenes/David/SpeedRunnerBase.gd"

onready var navigation2d : Navigation2D = get_tree().get_root().find_node("Navigation2D", true, false)

onready var level = get_parent()

var current_destination = Vector2()

var path = []

export var waypoint_tolerance : float = 5.0


# Called when the node enters the scene tree for the first time.
func _ready():
	if level == null:
		print("Could not find level!")
	#pass # Replace with function body.


func _physics_process(delta):
	navigate_to_destination()
	animate()


func navigate_to_destination():
	direction = Vector2()
	if path.size() > 0:
		print("NAV : ", position, path[0])
		var distance_to_destination = position.distance_to(path[0])
		if distance_to_destination > waypoint_tolerance:
			direction = path[0] - position
			move_direction()
		else:
			path.remove(0)


func _unhandled_input(event):
	if not event is InputEventMouseButton:
		return
	
	if event.button_index != BUTTON_LEFT or not event.pressed:
		return
	
	current_destination = event.global_position
	if level.has_method("find_path_to_destination"):
		path = level.find_path_to_destination(position, current_destination)
		if path != null:
			print("Found path : ",path)

