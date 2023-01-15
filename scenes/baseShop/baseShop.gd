extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var shopKeeperArea=get_node("shopKeeper/shopKeeperArea")
onready var playerArea=get_node("player/Area2D")
onready var shopKeeperPopup=get_node("shopKeeperDialogueBox/shopKeeperPopup")


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

