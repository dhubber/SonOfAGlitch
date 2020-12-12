extends Area2D

#Automatically make connection to parent node
func _ready():
	self.connect("body_shape_entered",get_parent(),"OnSelectGlitch")
	self.connect("body_shape_exited",get_parent(),"OnDeselectGlitch")

