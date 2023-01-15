extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var popup=$Popup


#func _process(delta):
#	if shopKeeperArea.overlaps_area(playerArea) and Input.is_action_just_pressed("ui_select"):
#		shopKeeperPopup.visible=true
		#var shopKeeperDialogue=preload("res://assets/baseShop/dialogueBox/shopKeeperDialogueBox.tscn")
		#var shopKeeperInstance=shopKeeperDialogue.instance()
		#shopKeeperInstance.visible=true
		#self.add_child(shopKeeperInstance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_exit_pressed():
	for n in popup.get_children():
		if n.name!="exit":
			popup.remove_child(n)
			n.queue_free()
	popup.hide()
