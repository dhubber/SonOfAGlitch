extends Area2D

onready var light := $Light2D
onready var gen = RandomNumberGenerator.new()

#Automatically make connection to parent node
func _ready():
	self.connect("body_shape_entered",get_parent(),"OnSelectGlitch")
	self.connect("body_shape_exited",get_parent(),"OnDeselectGlitch")
	
func _changeLight():
	
	gen.randomize()
	var random = gen.randf_range(0,3)
	
	if random > 1:
		light.color = Color.red
	elif random > 2:
		light.color = Color.green
	else:
		light.color = Color.blue
