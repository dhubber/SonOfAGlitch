extends Node2D

# Declare member variables here. Examples:
export var cooldownTime : float = 5
var cooldownTimeRemaining : float

var text : RichTextLabel


func _ready():
	text = get_node("RichTextLabel")


func _process(delta):
	if cooldownTimeRemaining > 0:
		cooldownTimeRemaining -= delta

#		Display cooldown time temp
		text.text = String(stepify(cooldownTimeRemaining,1))
		
		if cooldownTimeRemaining <= 0:
			OnCooldownComplete()
			
			
			
func OnActivateGlitch():
	if cooldownTimeRemaining > 0: return
	cooldownTimeRemaining = cooldownTime
	print("Glitch activated!")


func OnCooldownComplete():
	print("Glitch regened!")
	text.text = ""
