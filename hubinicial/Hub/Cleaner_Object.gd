extends Node2D

var cleaning = false
var tile_id = -1

func _on_Area2D_body_entered(body):
	if cleaning :
		print(body.name)
func _process(delta):
	if cleaning :
		self.global_position = get_global_mouse_position()
