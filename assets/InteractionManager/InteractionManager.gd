extends Area2D

class_name InteractionManager

var currentInteraction: InteractionManager

func startInteraction()->void:
	if currentInteraction!=null:
		currentInteraction.recieveInteraction()

func recieveInteraction()->void:
	print("No interaction recepction behavior defined.")

func _on_InteractionManager_area_entered(area):
	currentInteraction=area


func _on_InteractionManager_area_exited(area):
	if currentInteraction==area:
		currentInteraction=null
