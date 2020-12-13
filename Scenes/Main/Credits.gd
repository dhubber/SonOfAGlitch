extends Control

var mainMenu_button



# Called when the node enters the scene tree for the first time.
func _ready():
	mainMenu_button = get_node("TextureButton")
	
	
	mainMenu_button.connect("pressed", self, "_menu_pressed")
	


func _menu_pressed():

	get_tree().change_scene("res://Scenes/Main/MainMenu.tscn")



