extends Node2D

export var max_no_runners : int = 2
export var spawn_time : float = 5.0

onready var navigation2d : Navigation2D = $Navigation2D
onready var ai_runner = preload("res://Scenes/David/AISpeedRunner.tscn")

var runners = []
var spawn_points = []
var tasks = []
var assigned_tasks = []

var no_runners = 0

signal refresh_pathfinding


func _ready():
	randomize()
	
	# Find all tasks
	tasks = get_tree().get_nodes_in_group("Task")
	for task in tasks:
		task.connect("task_completed", self, "task_completed")
	print("Found ",tasks.size()," in level")
	
	spawn_points = get_node("SpawnPoints").get_children()
	
	$SpawnTimer.start(1.0)


func find_random_task():
	if tasks.size() > 0:
		var index = randi() % tasks.size()
		var task = tasks[index]
		tasks.remove(index)
		assigned_tasks.push_back(task)
		return task
	else:
		return null


func spawn_runner():
	if spawn_points.size() > 0:
		var index = randi() % spawn_points.size()
		var spawn_point = spawn_points[index]
		var runner = ai_runner.instance()
		if runner != null:
			no_runners += 1
			runner.position = spawn_point.position
			get_node("SpeedRunners").add_child(runner)
			runner.set_level(self)
			if no_runners < max_no_runners:
				$SpawnTimer.start(spawn_time)


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
