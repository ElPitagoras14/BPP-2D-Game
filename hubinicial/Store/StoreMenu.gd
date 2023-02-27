extends Control

onready var addMenu = $AddMenu
onready var arbolMenu = $ArbolGiganteMenu
onready var optionsPopup = $StoreOptionsPopUp
onready var parent = get_node("/root/GameHub2D")
onready var object_editor = get_node("/root/GameHub2D/Editor_Object")
onready var cursor_sprite = object_editor.get_node("Sprite")
onready var cleaner_object = get_node("/root/GameHub2D/Cleaner_Object")
onready var hudStore = parent.get_node("HudStore")


export var price:int

func showPopup():
	optionsPopup.show()
	$TrashMenu.hide()
	arbolMenu.hide()
	addMenu.hide()

func show_warning():
	$WarningMsg.show()
	$TrashMenu/TutorialMsg.visible = false
func hide_warning():
	$WarningMsg.hide()
	$TrashMenu/TutorialMsg.visible = true

func _on_AddElementsButton_pressed():
	show()
	addMenu.show()
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
	parent.cancelar_upgrades()
	$AddMenu.hide()


func _on_TabStoreContainer_mouse_entered():
	object_editor.can_place +=1

func _on_TabStoreContainer_mouse_exited():
	object_editor.can_place -= 1

func _on_GuardarButton_pressed():
	parent.save_user_map()
	$AddMenu.hide()
	
#Managers de upgrades de reciclaje
func _on_RecicleButton_pressed():
	show()
	$TrashMenu.show()
	var waterCan_scene = load("res://hubinicial/Store/Objects/WaterCan.tscn")
	var instance = waterCan_scene.instance()
	cleaner_object.get_node("Sprite").texture = instance.get_node("Sprite").texture
	cleaner_object.get_node("Area2D").add_child(instance.get_node("Area2Detection/CollisionShape2D").duplicate())
	cleaner_object.cleaning = true
	cleaner_object.check_enough_currency()
	parent.is_freeCam_active = true
	optionsPopup.hide()
	

func _on_reciclar_button_mouse_entered():
	cleaner_object.tile_selected -= 1

func _on_reciclar_button_mouse_exited():
	cleaner_object.tile_selected += 1

func _on_reciclar_cancel_pressed():
	$TrashMenu.hide()
	parent.cancelar_reciclaje()

	
func _on_reciclar_guardar_pressed():
	$TrashMenu.hide()
	parent.save_trash_map()


func disableArbolesIsUpgradedButton(var tree:Node):
	tree.get_node("ArbolButton").disabled = true
	tree.get_node("FrontLabel").text = "Árbol recuperado"

#Managers RevivirArboles
func _on_RevivirButton_pressed():
	show()
	arbolMenu.show()
	optionsPopup.hide()
	hudStore.set_label_monedas()
	if(hudStore.monedas_temp < 1000):
		for child in arbolMenu.get_node("Options").get_children():
			child.get_node("ArbolButton").disabled = true
		arbolMenu.get_node("WarningText").show()
		arbolMenu.get_node("PriceMesasge").hide()
	else:
		arbolMenu.get_node("PriceMesasge").show()
		arbolMenu.get_node("WarningText").hide()
		if(GameManager.player != null):
			var upgrades = GameManager.player.level['Arboles']
			for key in upgrades.keys():
				if("NE" in key):
					if upgrades[key]:
						disableArbolesIsUpgradedButton(arbolMenu.get_node("Options/NinePatchNE"))
				elif("NO" in key):
					if upgrades[key]:
						disableArbolesIsUpgradedButton(arbolMenu.get_node("Options/NinePatchNO"))
				elif("SO" in key):
					if upgrades[key]:
						disableArbolesIsUpgradedButton(arbolMenu.get_node("Options/NinePatchSO"))
				elif("SE" in key):
					if upgrades[key]:
						disableArbolesIsUpgradedButton(arbolMenu.get_node("Options/NinePatchSE"))
	
func _on_RegresarButton_pressed():
	arbolMenu.hide()
	optionsPopup.show()	

func _on_ArbolButtonNE_pressed():
	arbolMenu.hide()
	parent._CutsceneAnimationPlayer_play_upgrade_animation("upgradeT_NETrees")
	

func _on_ArbolButtonNO_pressed():
	hide()
	arbolMenu.hide()
	parent._CutsceneAnimationPlayer_play_upgrade_animation("upgradeT_NOTrees")

func _on_ArbolButtonSE_pressed():
	hide()
	arbolMenu.hide()
	parent._CutsceneAnimationPlayer_play_upgrade_animation("upgradeT_SETrees")


func _on_ArbolButtonSO_pressed():
	hide()
	arbolMenu.hide()
	parent._CutsceneAnimationPlayer_play_upgrade_animation("upgradeT_SOTrees")
