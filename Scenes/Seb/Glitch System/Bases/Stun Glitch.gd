extends "res://Scenes/Seb/Glitch System/Bases/GlitchAreaBase.gd"

func GlitchRunner(runner):
	.GlitchRunner(runner)
	if runner.has_function("SetMovementSpeedMultiplier"):
		runner.SetMovementSpeedMultiplier(0)
	else: print("Set movement multiplier here")

func UnglitchRunner(runner):
	.UnglitchRunner(runner)
	if runner.has_function("SetMovementSpeedMultiplier"):
		runner.SetMovementSpeedMultiplier(1)
	else: print("Set movement multiplier here")
