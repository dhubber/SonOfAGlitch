extends "res://Scenes/Seb/Glitch System/Glitch Base.gd"

export var activeTime : float = 2
var glitchActive : bool
var affectedRunners = []
var inrangeRunners = []

	
func _process(delta):
	._process(delta)

#	Deactivate if time passed since activation is larger than active time
	if glitchActive && cooldownTimeRemaining < cooldownTime - activeTime:
		DeactivateGlitch()
		

func OnActivateGlitch():
	if glitchActive: return
	.OnActivateGlitch()
	text.modulate.r = 1
	text.modulate.g = 0
	text.modulate.b = 0

#	Glitch all runners in range
	for r in inrangeRunners:
		GlitchRunner(r)
		
	glitchActive = true


func DeactivateGlitch():
	if !glitchActive: return
	text.modulate.r = 0
	text.modulate.g = 0
	text.modulate.b = 1
	
	#	Ungitch all runners in range
	for r in affectedRunners:
		UnglitchRunner(r)
		
	glitchActive = false


func OnRunnerEnter(body):
	inrangeRunners.push_back(body)
	
	if (glitchActive):
		GlitchRunner(body)
	
	print("Enter" + body.name)


func OnRunnerExit(body):
	inrangeRunners.erase(body)
	print("Exit" + body.name)


func GlitchRunner(runner):
	affectedRunners.push_back(runner)
	return

func UnglitchRunner(runner):
	affectedRunners.erase(runner)
	return
