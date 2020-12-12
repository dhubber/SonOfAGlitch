extends "res://Scenes/Seb/Glitch System/Bases/GlitchBase.gd"

var collider : CollisionShape2D

func _ready():
	._ready()
	collider = get_node("StaticBody2D/CollisionShape2D")
	collider.disabled = true
	
func OnActivateGlitch():
	if !.OnActivateGlitch(): return
	
	collider.disabled = false
	print("Door closed")
	
func OnDeactivateGlitch():
	if !.OnDeactivateGlitch(): return
	
	collider.disabled = true
	print("Door open")
