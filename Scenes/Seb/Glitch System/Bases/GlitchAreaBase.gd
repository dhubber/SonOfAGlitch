extends "res://Scenes/Seb/Glitch System/Bases/GlitchBase.gd"


var affectedRunners = []
var inrangeRunners = []

func OnSelectGlitch(body): .OnSelectGlitch(body)
	
	
func OnDeselectGlitch(body): .OnDeselectGlitch(body)

func OnActivateGlitch():
	if glitchActive: return
	.OnActivateGlitch()

#	Glitch all runners in range
	for r in inrangeRunners:
		GlitchRunner(r)


func OnDeactivateGlitch():
	if !glitchActive: return
	.OnDeactivateGlitch()
	
	#	Unglitch all runners in range
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
	print("Glitching " + runner.name)
	affectedRunners.push_back(runner)
	return

func UnglitchRunner(runner):
	print("Unglitching " + runner.name)
	affectedRunners.erase(runner)
	return


func OnExitGlitch(area):
	pass # Replace with function body.
