extends KinematicBody2D

# PHYSICS
var speed = 256
var tile_size = 64

var last_position = Vector2()
var target_position = Vector2()
var movedir = Vector2()

func _ready():
	position = position.snapped(Vector2(tile_size,tile_size))
	last_position=position
	target_position=position
	
func get_movedir():
	var LEFT = Input.is_action_pressed("move_left")
	var RIGHT = Input.is_action_pressed("move_right")
	var UP = Input.is_action_pressed("move_up")
	var DOWN = Input.is_action_pressed("move_down")
	
	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN)	

	if movedir.x !=0 && movedir.y != 0:
		movedir = Vector2.ZERO		

func _process(delta):
	# MOVEMENT
	position += speed * movedir * delta
	
	#if stuff went wrong and we moved more than the tile_size, 
	#we will simply snap to the actual position
	if position.distance_to(last_position) >= tile_size - speed * delta:
		position = target_position
	
	# IDLE
	if position == target_position:
		get_movedir()
		last_position = position
		target_position += movedir * tile_size
	

