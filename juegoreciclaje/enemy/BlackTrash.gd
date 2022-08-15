extends Trash

export var horizontalSpeed := 20.0

var horizontalDirection: int = 1

func _physics_process(delta):
	position.x += horizontalSpeed * delta * horizontalDirection
	if position.x < -125 or position.x > 675:
		horizontalDirection *= -1
	
