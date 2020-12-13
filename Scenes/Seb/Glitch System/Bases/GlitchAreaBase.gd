extends "res://Scenes/Seb/Glitch System/Bases/GlitchBase.gd"


#References
var affectedRunners = []
var inrangeRunners = []
var sprite : Sprite


func _ready():
	._ready()
	sprite = get_node("Sprite")

func OnSelectGlitch(body, things, boring, whatever):
	.OnSelectGlitch(body, things, boring, whatever)
	
func OnDeselectGlitch(body, things, boring, whatever):
	.OnDeselectGlitch(body, things, boring, whatever)

func OnActivateGlitch():
	if glitchActive: return false
	.OnActivateGlitch()

#	Glitch all runners in range
	for r in inrangeRunners:
		GlitchRunner(r)

var time : float
func Update(delta):
	.Update(delta)
	time += time
	if activeTimer.is_stopped() && cooldownTimer.is_stopped() && glitchSelect:
		sprite.modulate.a = cos(time)
	else : sprite.modulate.a = 0.0

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
