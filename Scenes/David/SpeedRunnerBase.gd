extends KinematicBody2D

export var walk_speed = 200.0 

onready var animatedSprite = get_node("AnimatedSprite")

var direction = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func move_direction():
	var velocity = direction * walk_speed
	velocity = move_and_slide(velocity)
	direction = velocity.normalized()


func animate():
	if direction.length_squared() > 0:
		animatedSprite.play("walk")
		if direction.x > 0:
			animatedSprite.flip_h = true
		elif direction.x < 0:
			animatedSprite.flip_h = false
	else:
		animatedSprite.play("idle")
