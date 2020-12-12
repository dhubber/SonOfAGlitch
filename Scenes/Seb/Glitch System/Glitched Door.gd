extends "res://Scenes/Seb/Glitch System/Bases/GlitchBase.gd"

var collider : CollisionShape2D

func _ready():
	._ready()
	collider = get_node("StaticBody2D/CollisionShape2D")
	collider.disabled = true
	
func OnActivateGlitch():
	if glitchActive: return
	.OnActivateGlitch()
	collider.disabled = false
	
func OnDeactivateGlitch():
	if !glitchActive: return
	.OnDeactivateGlitch()
	collider.disabled = true
