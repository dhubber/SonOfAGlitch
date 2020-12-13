extends KinematicBody2D

# PHYSICS
export var speed = 512
var tile_size = 128
var last_position = Vector2()
var target_position = Vector2()
var movedir = Vector2()

var interaction_area

# TILEMAP
var pipes_tilemap
var in_pipes 

# VARIABLES
var map_ui

func _ready():
	position = position.snapped(Vector2(tile_size/2,tile_size/2))
	last_position=position
	target_position=position
	
	# get pipes
	pipes_tilemap = get_node("../PipesTilemap")
	print(pipes_tilemap.name)
	in_pipes = true;	
	map_ui = get_node("../HUD/Map")
	map_ui.visible = false
	
	#interaction_area = get_node("InteractArea")
	#interaction_area.connect("body_entered", self, "glitch_entered")

# Toggle pipes visibility
func toggle_pipes():
	print("Toggle tiles")
	in_pipes = not in_pipes
	if in_pipes:
		pipes_tilemap.show()
	else:
		pipes_tilemap.hide()

func set_pipes(enabled : bool):
	in_pipes = enabled
	if in_pipes:
		pipes_tilemap.show()
	else:
		pipes_tilemap.hide()

func toggle_map():
	map_ui.visible = not map_ui.visible
	pass

#Check for movement input
func get_movedir():
	var LEFT = Input.is_action_pressed("move_left")
	var RIGHT = Input.is_action_pressed("move_right")
	var UP = Input.is_action_pressed("move_up")
	var DOWN = Input.is_action_pressed("move_down")
	
	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN)	

	if movedir.x !=0 && movedir.y != 0:
		movedir = Vector2.ZERO		

#Update funtion kinda
func _process(delta):
	
	# Check if pipes were toggled
	if Input.is_action_just_pressed("toggle_pipes"):
		toggle_pipes()
	
	#Check if map was toggled
	if Input.is_action_just_pressed("toggle_map"):
		toggle_map()
		
	# MOVEMENT

	position += speed * movedir * delta

	#if stuff went wrong and we moved more than the tile_size, 
	#we will simply snap to the actual position
	if position.distance_to(last_position) >= tile_size - speed * delta:
		position = target_position

	# Only check for input when target_position was reached
	if position == target_position:
		
		last_position = position
		get_movedir()
		
		#check for collision
		var temp = move_and_collide(movedir*tile_size)
		#this needs to be set, otherwise move_and_collide sets position wrong
		position = last_position
		
		#if no collision is detected, glitch moves
		if not temp:
			target_position += movedir * tile_size
		else:
			movedir = Vector2.ZERO
	

#func glitch_entered():
#	print("Hello")
