extends KinematicBody2D

#stats
#prolly dont need this
var score : int = 0

#physics
var speed : int = 100
var vel : Vector2 = Vector2()


#components
onready var sprite = $Sprite


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
