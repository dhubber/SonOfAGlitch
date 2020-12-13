extends Area2D


#var assigned_runner = null
var assigned_runners = []

onready var done_sprite := $SpriteOff
onready var active_sprite := $SpriteOff


signal task_completed(task)


# Called when the node enters the scene tree for the first time.
func _ready():
	done_sprite.hide()


func add_assigned_runner(runner):
	assigned_runners.push_back(runner)


func remove_assigned_runner(runner):
	var index = assigned_runners.find(runner)
	if index != -1:
		assigned_runners.remove(index)


func is_assigned():
	return assigned_runners.size() > 0


func _on_TaskBase_body_entered(body):
	print("Body entered task!")
	if assigned_runners.find(body) == -1:
		return
		
	if body.is_in_group("SpeedRunner"):
		if body.has_method("task_complete"):
			body.task_complete()
		for runner in assigned_runners:
			runner.task_complete()
		assigned_runners.empty()
		emit_signal("task_completed", self)
		active_sprite.hide()
		done_sprite.show()
