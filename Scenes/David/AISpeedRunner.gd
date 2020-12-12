extends "res://Scenes/David/SpeedRunnerBase.gd"

export var waypoint_tolerance : float = 5.0

onready var navigation2d : Navigation2D = get_tree().get_root().find_node("Navigation2D", true, false)
onready var level = get_parent()

var current_destination = Vector2()
var assigned_task = null
var path = []


func _ready():
	if level == null:
		print("Could not find level!")
	$TaskWaitTimer.start()


func _physics_process(delta):
	navigate_to_destination()
	animate()


func find_next_task():
	if level != null:
		if level.has_method("find_random_task"):
			assigned_task = level.find_random_task()
			if assigned_task != null:
				assigned_task.set_assigned_runner(self)
				path = level.find_path_to_destination(position, assigned_task.position)
				if path != null:
					print("Found path : ",path)
			else:
				$TaskWaitTimer.start()


func navigate_to_destination():
	direction = Vector2()
	if path.size() > 0:
		var distance_to_destination = position.distance_to(path[0])
		if distance_to_destination > waypoint_tolerance:
			direction = path[0] - position
			move_direction()
		else:
			path.remove(0)


func task_complete():
	assigned_task = null
	$TaskWaitTimer.start()


func _on_Timer_timeout():
	find_next_task()


#func _unhandled_input(event):
#	if not event is InputEventMouseButton:
#		return
#
#	if event.button_index != BUTTON_LEFT or not event.pressed:
#		return
#
#	current_destination = event.global_position
#	if level.has_method("find_path_to_destination"):
#		path = level.find_path_to_destination(position, current_destination)
#		if path != null:
#			print("Found path : ",path)
