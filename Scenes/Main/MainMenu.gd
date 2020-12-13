extends MarginContainer



var start_button
var exit_button
var credits_button
var about_button



# Called when the node enters the scene tree for the first time.
func _ready():
	start_button = get_node("HSplitContainer/CenterContainer2/MenuOptions/Start")
	exit_button = get_node("HSplitContainer/CenterContainer2/MenuOptions/Exit")
	credits_button = get_node("HSplitContainer/CenterContainer2/MenuOptions/Credits")
	about_button = get_node("HSplitContainer/CenterContainer2/MenuOptions/About")
	
	
	
	start_button.connect("pressed", self, "_start_pressed")
	exit_button.connect("pressed", self, "_exit_pressed")
	credits_button.connect("pressed", self, "_credits_pressed")
	about_button.connect("pressed", self, "_about_pressed")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _start_pressed():

	get_tree().change_scene("res://Scenes/Main/Main_Scene.tscn")

func _exit_pressed():
	get_tree().quit()

func _credits_pressed():
	print("Credits pressed")
	
func _about_pressed():
	print("Credits pressed")
