extends Node2D

onready var navigation2d : Navigation2D = $Navigation2D

var tasks = []


func _ready():
	randomize()
	tasks = get_tree().get_nodes_in_group("Task")
	for task in tasks:
		task.connect("task_completed", self, "task_completed")
	print("Found ",tasks.size()," in level")


func find_random_task(current_position):
	if tasks.size() > 0:
		var index = randi() % tasks.size()
		var task = tasks[index]
		return find_path_to_destination(current_position, task.position)
	else:
		return PoolVector2Array()


func find_path_to_destination(current_position, destination):
	if navigation2d != null:
		print("Finding path : ", current_position, destination)
		var path = navigation2d.get_simple_path(current_position, destination)
		return path
	else:
		return PoolVector2Array()


func task_completed(task):
	var index = tasks.find(task)
	if index != -1:
		tasks.remove(index)
		print("Number of remaining tasks : ", tasks.size())
		if tasks.size() == 0:
			print("SpeedRun complete!")
		else:
			pass
