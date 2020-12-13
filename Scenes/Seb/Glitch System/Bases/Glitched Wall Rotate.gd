extends "res://Scenes/Seb/Glitch System/Bases/GlitchBase.gd"

var degRotation : int

#State
var startRot : float
var targetRot : float

#func _ready():
#	._ready()
	
func Update(delta):
	.Update(delta)
	if !activeTimer.is_stopped():
		rotation_degrees = lerp_angle(startRot, targetRot, activeTimer.time_left / activeTime)
	
	
func OnActivateGlitch():
	if glitchActive: return
	.OnActivateGlitch()
	startRot = rotation_degrees
	targetRot = rotation_degrees + degRotation

	
func OnDeactivateGlitch():
	if !glitchActive: return
	.OnDeactivateGlitch()

static func lerp_angle(a, b, t):
	if abs(a-b) >= PI:
		if a > b:
			a = normalize_angle(a) - 2.0 * PI
		else:
			b = normalize_angle(b) - 2.0 * PI
	return lerp(a, b, t)

static func normalize_angle(x):
	return fposmod(x + PI, 2.0*PI) - PI
