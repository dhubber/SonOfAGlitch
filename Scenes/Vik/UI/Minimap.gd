extends MarginContainer


export (NodePath) var player
export var zoom = 1.5

onready var grid = $MarginContainer/Grid
onready var player_marker = $MarginContainer/Grid/PlayerMarker
onready var speedrunner_marker = $MarginContainer/Grid/SpeedrunnerMarker
onready var glitch_marker = $MarginContainer/Grid/GlitchMarker
onready var task_marker = $MarginContainer/Grid/TaskMarker

onready var icons = {"Speedrunner"}
