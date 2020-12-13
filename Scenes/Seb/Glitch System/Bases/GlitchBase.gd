extends Node2D

# Declare member variables here. Examples:
export var activeTime : float = 0
export var cooldownTime : float = 5

#State
var glitchActive : bool
var glitchSelect : bool
var time : float

#References
var text : RichTextLabel
var cooldownTimer : Timer
var activeTimer : Timer
onready var level = get_tree().get_root().get_node("LevelBase")
onready var hud = get_tree().get_root().get_node("LevelBase/HUD")
onready var selectParticles := $CPUParticles2D
onready var accessParticles := find_node("AccessParticles")


func _ready():
	text = get_node("RichTextLabel")
	cooldownTimer = get_node("Cooldown Timer")
	activeTimer = get_node("Active Timer")


#UnityMasterrace
func _process(delta): Update(delta)


func Update(delta):
	time += time
	
#	Display timing
	if !activeTimer.is_stopped():
		text.text = String(ceil(activeTimer.time_left))
	elif !cooldownTimer.is_stopped():
		text.text = String(ceil(cooldownTimer.time_left))
		
	if glitchSelect && Input.is_action_just_pressed("execute_glitch"):
		OnActivateGlitch()
		
	selectParticles.emitting = activeTimer.is_stopped() && cooldownTimer.is_stopped() && glitchSelect

#Indicates the player is at the glitch location, priming the glitch for execution
func OnSelectGlitch(body, things, boring, whatever):
	glitchSelect = true
	hud._enable_glitch()
	print("Entered glitch" + name)
	
func OnDeselectGlitch(body, things, boring, whatever): 
	glitchSelect = false
	hud._disable_glitch()
	print("Left glitch" + name)
	

#Executes the glitch
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
		
		accessParticles.emitting = false;
		
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
	accessParticles.emitting = true;

