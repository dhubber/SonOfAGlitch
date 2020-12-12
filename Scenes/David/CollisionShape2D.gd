extends CollisionShape2D


var task_completed : bool = false;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_TaskBase_body_entered(body):
	if body.is_in_group("SpeedRunner"):
		print("In group")
