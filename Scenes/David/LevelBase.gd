extends Node2D

onready var navigation2d : Navigation2D = $Navigation2D

var tasks = []
var assigned_tasks = []

signal refresh_pathfinding


func _ready():
	randomize()
	tasks = get_tree().get_nodes_in_group("Task")
	for task in tasks:
		task.connect("task_completed", self, "task_completed")
	print("Found ",tasks.size()," in level")


func find_random_task():
	if tasks.size() > 0:
		var index = randi() % tasks.size()
		var task = tasks[index]
		tasks.remove(index)
		assigned_tasks.push_back(task)
		return task
	else:
		return null

func refresh_pathfinding():
	print("Forcing pathfinding to refresh")
	emit_signal("refresh_pathfinding")

func find_path_to_destination(current_position, destination):
	if navigation2d != null:
		print("Finding path : ", current_position, destination)
		var path = navigation2d.get_simple_path(current_position, destination, false)
		return path
	else:
		return PoolVector2Array()


func task_completed(task):
	var index = assigned_tasks.find(task)
	if index != -1:
		assigned_tasks.remove(index)
		print("Number of remaining tasks : ", tasks.size() + assigned_tasks.size())
		if tasks.size() + assigned_tasks.size() == 0:
			all_tasks_completed()
		else:
			pass


func task_abandoned(task):
	var index = assigned_tasks.find(task)
	if index != -1:
		assigned_tasks.remove(index)
		tasks.push_back(task)
		task.set_assigned_runner(null)


func all_tasks_completed():
	print("SpeedRun complete!")
	$LevelChangeTimer.start()


func game_over():
	get_tree().change_scene("res://Scenes/Main/MainMenu.tscn")
