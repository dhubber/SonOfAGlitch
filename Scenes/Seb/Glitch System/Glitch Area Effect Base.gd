extends "res://Scenes/Seb/Glitch System/Glitch Base.gd"

var affectedRunners = []
var inrangeRunners = []

func OnActivateGlitch():
	if glitchActive: return
	.OnActivateGlitch()

#	Glitch all runners in range
	for r in inrangeRunners:
		GlitchRunner(r)


func DeactivateGlitch():
	if !glitchActive: return
	.DeactivateGlitch()
	
	#	Glitch all runners in range
	for r in affectedRunners:
		UnglitchRunner(r)


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
