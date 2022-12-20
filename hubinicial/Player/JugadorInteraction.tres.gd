extends InteractionManager

onready var alertIcon=$"../alertIcon"


func _on_InteractionManager_area_entered(area):
	currentInteraction=area
	alertIcon.visible=true

func _on_InteractionManager_area_exited(area):
	if currentInteraction==area:
		currentInteraction=null
	alertIcon.visible=false
