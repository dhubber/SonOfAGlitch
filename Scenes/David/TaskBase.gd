extends Area2D


var level = null
var assigned_runner = null
onready var active_sprite := $SpriteOn
onready var done_sprite := $SpriteOff


signal task_completed(task)


# Called when the node enters the scene tree for the first time.
func _ready():
	done_sprite.hide()


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
		active_sprite.hide()
		done_sprite.show()
