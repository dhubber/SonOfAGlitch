extends CanvasLayer


var settings_button
var glitch_button
var map_button
var map


# Called when the node enters the scene tree for the first time.
func _ready():
	settings_button = get_node("SettingsButton")
	glitch_button = get_node("GlitchButton")
	map_button = get_node("MapButton")
	map = get_node("Map")
	
	settings_button.connect("pressed", self, "_settings_pressed")
	glitch_button.connect("pressed", self, "_glitch_pressed")
	map_button.connect("pressed", self, "_map_pressed")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _settings_pressed():
	print("Settings Pressed")

func _glitch_pressed():
	print("Glitch Pressed")

func _map_pressed():
	print("Map pressed")
	map.visible = not map.visible
