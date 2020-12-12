extends KinematicBody2D

export var walk_speed = 200.0 

onready var animatedSprite = get_node("AnimatedSprite")

var direction = Vector2()
var speed_multiplier : float = 1.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func move_direction():
	if direction.length_squared() > 0:
		direction = direction.normalized()
		var velocity = direction * walk_speed * speed_multiplier
		velocity = move_and_slide(velocity, Vector2(), false, 64)
		direction = velocity.normalized()
	else:
		direction = Vector2()


func animate():
	if direction.length_squared() > 0:
		animatedSprite.play("walk")
		if direction.x > 0:
			animatedSprite.flip_h = true
		elif direction.x < 0:
			animatedSprite.flip_h = false
	else:
		animatedSprite.play("idle")


func task_complete():
	pass


func set_movement_speed_multiplier(new_speed_multiplier):
	speed_multiplier = new_speed_multiplier

