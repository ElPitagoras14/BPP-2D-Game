extends Node2D

onready var player = $Jugador
onready var playerCamera = $Jugador/Camera2D
onready var dialog = $Hud/DialogPopUp
onready var freeCam = $CutsceneCam2D
onready var cameraCutAnimation = $CutsceneCam2D/AnimationPlayer
onready var speakerAnimation = $Hud/DialogPopUp/SpeakerSprite/SpeakerAnimation
onready var HUD = $Hud/MainHud
onready var StoreHud = $HudStore
onready var animationTimer = $AnimationTimer
onready var MagicEffectScene = load("res://hubinicial/Hub/MagicEffect.tscn")

var user_objects = {'Arbol':"res://hubinicial/Store/Objects/Arbol.tscn",\
					'Wolf':"res://hubinicial/Store/Objects/Wolf.tscn"}

var RECOVER_TREE_PRICE = 1000

var is_freeCam_active = false
var CAMERA_SPEED = 5

func activatePlayer():
	player.stopControls = false
	playerCamera.current = true
	is_freeCam_active = false

func activateFreeCam():
	player.stopControls = true
	freeCam.current = true
	
func showStorePopUp():
	$HudStore/StoreMenu.showPopup()
	activateFreeCam()

func _ready():
	
	$Hud/ColorRect/FadeInAnimation.play("FadeIn")
	if(GameManager.currentPlayer):
		GameManager.loadPlayer(GameManager.currentPlayer)
		player.position.x = GameManager.player["ubicacion"]["x"]
		player.position.y = GameManager.player["ubicacion"]["y"]
		
	else: #If load fails, default
		player.position.x = 0
		player.position.y = 0
		
	if(GameManager.newGameFlag):#Play tutorial cutscene
		activateFreeCam()
		HUD.stopControls = true
		dialog.start()
		dialog.popup_exclusive = true
		GameManager.newGameFlag = false
		animationTimer.start()
	else:
		load_user_map()
		check_mejoras()
		activatePlayer()


func _input(event):
	
	if event.is_action_pressed("ui_select") and dialog.dActive:
		speakerAnimation.play("speak")
		if(dialog.currentDialogueId == 2):
			cameraCutAnimation.play("AreaPan")
		elif(dialog.currentDialogueId == 9):
			cameraCutAnimation.stop(true)
			playerCamera.current = true
		elif(dialog.currentDialogueId == 10):
			speakerAnimation.stop(true)
			dialog.get_node("SpeakerSprite").visible = false
			dialog.get_node("PopUp").visible = false
			$Hud/DialogPopUp/Arrow.visible = true
			$Hud/DialogPopUp/Arrow/ArrowAnimation.play("Move")
			var hbox = HUD.get_node_or_null('HBoxContainer')
			hbox.show()
		elif(dialog.currentDialogueId > 10):
			var hbox = HUD.get_node_or_null('HBoxContainer').hide()
			
			activatePlayer()
			HUD.stopControls = false
			dialog.popup_exclusive = false
			dialog.hide()
			
	if is_freeCam_active:
		
		if Input.is_action_pressed("ui_down"):
			freeCam.global_position.y += 30
		elif Input.is_action_pressed("ui_up"):
			freeCam.global_position.y -= 30
		elif Input.is_action_pressed("ui_left"):
			freeCam.global_position.x -= 30
		elif Input.is_action_pressed("ui_right"):
			freeCam.global_position.x += 30

func showHUD():
	$Hud.visible = true
	$Hud/MainHud.visible = true
	$HudStore.visible = false
	activatePlayer()

func clean_name(var name:String):
	return str(name.replace("@", "").replace(str(int(name)), ""))
	
func save_user_map():
	var user_level = $UserLevel
	var childs  = user_level.get_children()
	if(GameManager.currentPlayer):
		var data_array = []
		for child in childs:
			var data = {"name":clean_name(child.name),
			 "pos_x": child.position.x,
			 "pos_y" : child.position.y}
			data_array.append(data)
		GameManager.save_user_level(data_array)
	else:
		push_error("Error al guardar")

func load_user_map():
	var user_level = $UserLevel
	if (GameManager.currentPlayer):
		GameManager.loadPlayer(GameManager.currentPlayer)
		if(GameManager.player.level):
			for obj in GameManager.player.level:
				var instance_path = user_objects.get(obj.name)
				if instance_path:
					var new_obj = load(instance_path).instance()
					new_obj.position.x = obj.pos_x
					new_obj.position.y = obj.pos_y
					user_level.add_child(new_obj)
		
	else:
		get_tree().change_scene("res://scenes/PantallaInicio.tscn")




func reset_Editor_Object():
	var obj = $Editor_Object
	obj.current_item = null
	obj.get_node("Sprite").texture = null

func check_mejoras():
	if(GameManager.currentPlayer):
		#Check mejoras de arboles
		var arboles = Array(GameManager.player['mejoras']["arboles"].keys())
		var count = 0
		for key in arboles:
			var is_upgraded = GameManager.player['mejoras']["arboles"][key]
			if(is_upgraded ):
				if("NE" in key):
					upgradeTrees("DynamicTreeNE")
					count += 1
				elif("NO" in key):
					upgradeTrees("DynamicTreeNO")
					count += 1
				elif("SO" in key):
					upgradeTrees("DynamicTreeSO")
					count += 1
				elif("SE" in key):
					upgradeTrees("DynamicTreeSE")
					count += 1
		if count == len(arboles):
			$LiveTreeBorder.visible = true
			$DeadTreesBorder.queue_free()
	return

#Crea la animacion de efectos para el árbol nodo de la ruta treeNodePath
func create_MagicEffects(treeNodePath:String):
	var DinamicTree = self.get_node(NodePath(treeNodePath))
	#Stop player on animation
	player.stopControls = true
	var newEffect = MagicEffectScene.instance()
	newEffect.position.x = DinamicTree.position.x
	newEffect.position.y = DinamicTree.position.y  +25
	newEffect.z_index = DinamicTree.z_index +1
	add_child(newEffect)

#Cambia la sprite de los arboles muertos a vivos	
func upgradeTrees(treeNodePath:String):
	var DinamicTree = self.get_node(NodePath(treeNodePath))
	DinamicTree.get_node("Sprite").frame_coords.x = 0

func _on_FadeInAnimation_animation_finished(anim_name):
	if(dialog.dActive):
		speakerAnimation.play("speak")
		animationTimer.start()

func _on_ArrowAnimation_animation_finished(anim_name):
	$Hud/DialogPopUp/Arrow.visible = false
	$Hud/DialogPopUp.remove_child($Hud/DialogPopUp/Arrow)

func _on_AnimationTimer_timeout():
	speakerAnimation.stop(true)

#Managers for overlapping TreeSprites
func _on_Dinamic_area_body_entered(body):
	body.z_index += 2
func _on_Dinamic_area_body_exited(body):
	body.z_index -= 2

func _on_CutsceneAnimationPlayer_animation_finished(anim_name, upgr_name):
	if("upgradeT" in anim_name):
		var upgr = anim_name.get_slice("_",1)  
		GameManager.player['mejoras']['arboles'][upgr] = true
		GameManager.player['monedas'] -= RECOVER_TREE_PRICE
		GameManager.savePlayerMonedas(GameManager.player['monedas']-RECOVER_TREE_PRICE)
		activatePlayer()
