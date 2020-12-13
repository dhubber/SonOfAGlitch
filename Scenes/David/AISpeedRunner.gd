extends "res://Scenes/David/SpeedRunnerBase.gd"

export var waypoint_tolerance : float = 5.0
export var rage_increase_rate : float = 10.0
export var rage_decrease_task : float = 10.0

onready var navigation2d : Navigation2D = get_tree().get_root().find_node("Navigation2D", true, false)
onready var level = get_parent()
onready var nameLabel := $RichTextLabel
onready var line2D := $Line2D

signal runner_rage_quit(runner)

var current_destination = Vector2()
var assigned_task = null
var path = []
var rage_value : float = 0.0
var enraged : bool = false


func _ready():
	$ProgressBar.value = 0.0


func set_level(new_level):
	level = new_level
	if level == null:
		print("Could not find level!")
	level.connect("refresh_pathfinding",self,"calculate_path")
	$TaskWaitTimer.start()

	# Assign name
	nameLabel.bbcode_text = "[center]" + level.get_name() + "[/center]"


func _physics_process(delta):
	rage_value += rage_increase_rate * delta
	$ProgressBar.value = rage_value
	if rage_value >= 100.0:
		if enraged == false:
			rage_quit()
	else:
		if enraged == false:
			navigate_to_destination()
			animate()
	
	
# Ensure lines are always drawn in world space. It ain't elegant
func _process(delta):
	line2D.transform.origin = -position
	if path.size() != 0:
		line2D.points = path


func find_next_task():
	if level != null:
		if level.has_method("find_random_task"):
			assigned_task = level.find_random_task()
			if assigned_task != null:
				assigned_task.add_assigned_runner(self)
				calculate_path()
			else:
				$TaskWaitTimer.start()


func calculate_path():
#	Try and make sure a task is assigned, otherwise return
	if assigned_task == null: find_next_task()
	if assigned_task == null: return
	
	path = level.find_path_to_destination(position, assigned_task.position)
	if path != null:
		print("Found path : ", path)

#		Draw new path
		line2D.points = path


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
	rage_value = clamp(rage_value - rage_decrease_task, 0.0, 100.0)
	$TaskWaitTimer.start()


func rage_quit():
	enraged = true
	print("I've had enough!")
	if assigned_task != null and level != null:
		assigned_task.remove_assigned_runner(self)
		level.task_abandoned(assigned_task)
	emit_signal("runner_rage_quit", self)
	queue_free()


func _on_Timer_timeout():
	find_next_task()
