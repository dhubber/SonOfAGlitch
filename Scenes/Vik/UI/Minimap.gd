extends MarginContainer


export (NodePath) var player
export var zoom = 1.5

onready var grid = $MarginContainer/Grid
onready var player_marker = $MarginContainer/Grid/PlayerMarker
onready var speedrunner_marker = $MarginContainer/Grid/SpeedrunnerMarker
onready var glitch_marker = $MarginContainer/Grid/GlitchMarker
onready var task_marker = $MarginContainer/Grid/TaskMarker

onready var icons = {"Speedrunner" : speedrunner_marker, "glitch": glitch_marker}

var grid_scale
var markers = {}

func _ready():
	
	
	grid.add_child(player_marker)
	
	grid_scale = grid.rect_size /(get_viewport_rect().size * zoom)
	
	var map_objects = get_tree().get_nodes_in_group("minimap_ojects")
	for item in map_objects:
		var new_marker = icons[item.minimap_icon].duplicate()
		grid.add_child(new_marker)
		new_marker.show()
		markers[item] = new_marker
	
	

func _process(delta):
	
	for item in markers:
		var obj_pos = (item.position - Vector2.ZERO) * grid_scale
		markers[item].position = obj_pos
