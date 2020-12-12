extends Node2D

# Declare member variables here. Examples:
export var activeTime : float = 0
export var cooldownTime : float = 5

#State
var glitchActive : bool

#References
var text : RichTextLabel
var cooldownTimer : Timer
var activeTimer : Timer


func _ready():
	text = get_node("RichTextLabel")
	cooldownTimer = get_node("Cooldown Timer")
	activeTimer = get_node("Active Timer")


func _process(delta): Update()

func Update():
	if !activeTimer.is_stopped():
#		Display active time temp
		text.text = String(int(activeTimer.time_left))
	elif !cooldownTimer.is_stopped():
#		Display cooldown time temp
		text.text = String(int(cooldownTimer.time_left))

func OnActivateGlitch():
	if !cooldownTimer.is_stopped() || !activeTimer.is_stopped(): return

#	Begin active countdown if the glitch is not single-shot
	if activeTime == 0:
		text.modulate.r = 0
		text.modulate.g = 0
		text.modulate.b = 1
		cooldownTimer.start(cooldownTime)
	else:
		text.modulate.r = 1
		text.modulate.g = 0
		text.modulate.b = 0
		glitchActive = true
		activeTimer.start(activeTime)
		
func OnDeactivateGlitch():
	if !glitchActive: return
	
	text.modulate.r = 0
	text.modulate.g = 0
	text.modulate.b = 1
	
	glitchActive = false
	cooldownTimer.start(cooldownTime)

func OnCooldownComplete():
	print("Glitch ready!")
	text.text = ""
