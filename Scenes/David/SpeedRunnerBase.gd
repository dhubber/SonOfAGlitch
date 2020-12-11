extends KinematicBody2D


export var walk_speed = 1.0 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func move_direction(direction):
	var destination = global_position + 100 * direction
	var velocity = direction * walk_speed
	look_at(destination)
	move_and_slide(velocity)
