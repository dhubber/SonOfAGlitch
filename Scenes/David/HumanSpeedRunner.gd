extends "res://Scenes/David/SpeedRunnerBase.gd"


func _physics_process(delta):
	player_input()
	move_direction()
	animate()


func player_input():
	direction = Vector2()
	
	# Up/down movement
	if Input.is_action_pressed("up") and not Input.is_action_pressed("down"):
		direction.y = -1
	elif Input.is_action_pressed("down") and not Input.is_action_pressed("up"):
		direction.y = 1
	
	# Left/right movement
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		direction.x = -1
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		direction.x = 1

