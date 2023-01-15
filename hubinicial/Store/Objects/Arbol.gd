extends Node2D

func _on_Dinamic_area_body_entered(body):
	if(body is KinematicBody2D):
		self.z_index -= 5
func _on_Dinamic_area_body_exited(body):
	if(body is KinematicBody2D):
		self.z_index += 5
