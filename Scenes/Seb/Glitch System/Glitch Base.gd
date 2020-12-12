extends Node2D

# Declare member variables here. Examples:
export var glitchTime : float = 5
var glitchActive : bool
var glitchTimeRemaining : float


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	



func _process(delta):
	if glitchActive:
		glitchTimeRemaining -= delta
		if glitchTimeRemaining < 0:
			DeactivateGlitch()
			
			
			
func OnActivateGlitch():
	if glitchActive: return
	glitchActive = true


func DeactivateGlitch():
	if !glitchActive: return
	glitchActive = false
