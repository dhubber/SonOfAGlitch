extends Area2D


#var assigned_runner = null
var assigned_runners = []

onready var sprite_off := $SpriteOff
onready var sprite_on := $SpriteOn
onready var light_on := $LightOn
onready var light_off := $LightOff


signal task_completed(task)


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_on.hide()
	light_on.enabled = false


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
		sprite_on.hide()
		sprite_off.show()
		light_on.enabled = true
		light_off.enabled = true
