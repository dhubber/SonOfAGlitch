extends Area2D


var level = null
var assigned_runner = null


signal task_completed(task)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_assigned_runner(runner):
	assigned_runner = runner


func is_assigned():
	return assigned_runner != null


func _on_TaskBase_body_entered(body):
	print("Body entered task!")
	if body != assigned_runner:
		return
		
	if body.is_in_group("SpeedRunner"):
		if body.has_method("task_complete"):
			body.task_complete()
		emit_signal("task_completed", self)
		queue_free()
