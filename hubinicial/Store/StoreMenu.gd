extends Control

onready var addMenu = $AddMenu
onready var optionsPopup = $StoreOptionsPopUp
onready var parent = get_node("/root/GameHub2D")
onready var object_editor = get_node("/root/GameHub2D/Editor_Object")
onready var cursor_sprite = object_editor.get_node("Sprite")
onready var cleaner_object = get_node("/root/GameHub2D/Cleaner_Object")

export var price:int

func showPopup():
	optionsPopup.show()

func _on_AddElementsButton_pressed():
	addMenu.visible = true
	self.visible = true
	optionsPopup.hide()
	parent.is_freeCam_active = true
	
func _on_Exit_pressed():
	parent.activatePlayer()
	parent.showHUD()
	visible = false
	optionsPopup.hide()

func _on_Exit_mouse_entered():
	object_editor.can_place += 1

func _on_Exit_mouse_exited():
	object_editor.can_place -=1

func _on_CancelarButton_pressed():
	parent.showHUD()
	parent.reset_Editor_Object()
	$AddMenu.hide()


func _on_RecicleButton_pressed():
	var shovel_scene = load("res://hubinicial/Store/Objects/Shovel.tscn")
	var instance = shovel_scene.instance()
	cleaner_object.get_node("Sprite").texture = instance.get_node("Sprite").texture
	cleaner_object.get_node("Area2D").add_child(instance.get_node("Area2Detection/CollisionShape2D").duplicate())
	cleaner_object.cleaning = true
#tilemap.tileset.remove_tile(id)

func _on_TabStoreContainer_mouse_entered():
	object_editor.can_place +=1

func _on_TabStoreContainer_mouse_exited():
	object_editor.can_place -= 1


func _on_GuardarButton_pressed():
	parent.save_user_map()

