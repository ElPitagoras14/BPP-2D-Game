extends Node2D

export (String,FILE,"*.png") var TextureBase1
export (String,FILE,"*.png") var TextureBase2
export (String,FILE,"*.png") var TextureBase3
export (String,FILE,"*.png") var TextureBase4
export (String,FILE,"*.png") var TextureBase5

onready var textureList=[TextureBase1,TextureBase2,TextureBase3,TextureBase4,
						TextureBase5]

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
onready var store_menu = get_node('HudStore')
onready var base=$Base
onready var baseEntrance=$Base/BaseEntrance

var user_objects = {'ArbolA':"res://hubinicial/Store/Objects/ArbolA.tscn",\
					'ArbolB':"res://hubinicial/Store/Objects/ArbolB.tscn",\
					'ArbolC':"res://hubinicial/Store/Objects/ArbolC.tscn",\
					'FlorA':"res://hubinicial/Store/Objects/FlorA.tscn",\
					'FlorB':"res://hubinicial/Store/Objects/FlorB.tscn",\
					'FlorR':"res://hubinicial/Store/Objects/FlorR.tscn",\
					'FlorW':"res://hubinicial/Store/Objects/FlorW.tscn",\
					'Wolf':"res://hubinicial/Store/Objects/Wolf.tscn"}

var temp_user_objects = []
var temp_deleted_tiles = []

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
	
	
#Base Texture
func loadBaseTexture(var level):
	var texturePath="../../images/"
	var scenePath="res://scenes/bases/"
	var baseBody=base.get_node("BaseBody")
	if level==0:
		base.remove_child(baseBody)
		base.remove_child(baseEntrance)
		baseBody.queue_free()
		baseEntrance.queue_free()
	else:
		baseEntrance.targetScene=scenePath+"base-"+str(level)+"/base-"+str(level)+".tscn"
		var texture=load(textureList[level-1])
		base.texture=texture

func _ready():
	var baseStats=GameManager.getBaseStats()
	GameManager.saveLastZone("",0,0)
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
	loadBaseTexture(baseStats["level"])

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
		
		if Input.is_action_just_pressed("ui_down"):
			freeCam.global_position.y += 75
		elif Input.is_action_just_pressed("ui_up"):
			freeCam.global_position.y -= 75
		elif Input.is_action_just_pressed("ui_left"):
			freeCam.global_position.x -= 75
		elif Input.is_action_just_pressed("ui_right"):
			freeCam.global_position.x += 75

func showHUD():
	$Hud.visible = true
	$Hud/MainHud.visible = true
	
	$HudStore.visible = false
	activatePlayer()

func clean_name(var name:String):
	return str(name.replace("@", "").replace(str(int(name)), ""))

func save_trash_map():
	reset_Cleaner_Object()

	if(GameManager.currentPlayer):
		var data_array = []
		for trash_cords in temp_deleted_tiles:
			var data = {
				"x":trash_cords.x,
				"y":trash_cords.y}
			data_array.append(data)
		GameManager.save_flower_level(data_array)
		GameManager.savePlayerMonedas(store_menu.monedas_temp)
		showHUD()
	else:
		push_error("Error al guardar")
	temp_deleted_tiles = []
	
	
func save_user_map():
	var user_level = $UserLevel
	var childs  = user_level.get_children()
	if(GameManager.currentPlayer):
		var data_array = []
		for child in childs:
			var data = {"name":clean_name(child.name),
			 "x": child.position.x,
			 "y" : child.position.y}
			data_array.append(data)
		GameManager.save_user_level(data_array)
		GameManager.savePlayerMonedas(store_menu.monedas_temp)
		showHUD()
		reset_Editor_Object()
	else:
		push_error("Error al guardar")
	temp_user_objects = []
	

func reset_Editor_Object():
	var obj = $Editor_Object
	obj.current_item = null
	obj.can_place = 1
	obj.get_node("Sprite").texture = null
	obj.get_node("Area2Detection").remove_child(obj.get_node("Area2Detection").get_child(0))

func cancelar_upgrades():
	reset_Editor_Object()
	for object in temp_user_objects:
		object.queue_free()
	temp_user_objects = []
	showHUD()
	
func cancelar_reciclaje():
	reset_Cleaner_Object()
	for tile_cords in temp_deleted_tiles:
		$Flowers.set_cell(tile_cords.x,tile_cords.y,0)
	showHUD()
	temp_deleted_tiles = []

func load_user_map():
	var user_level = $UserLevel
	if (GameManager.currentPlayer):
		GameManager.loadPlayer(GameManager.currentPlayer)
		if(GameManager.player.level):
			var upgrade_dic = GameManager.player.level.duplicate()
			var watered_flowers = upgrade_dic.get("Flowers")
			for flower_cords in  watered_flowers:
				$Flowers.set_cell(flower_cords.x,flower_cords.y,-1)
			upgrade_dic.erase('Flowers')

			for obj in upgrade_dic['Upgrades']:
				var instance_path = user_objects.get(obj.name)
				if instance_path:
					var new_obj = load(instance_path).instance()
					new_obj.position.x = obj.x
					new_obj.position.y = obj.y
					user_level.add_child(new_obj)
			
		
	else:
		get_tree().change_scene("res://scenes/PantallaInicio.tscn")

	
func reset_Cleaner_Object():
	var obj = $Cleaner_Object
	obj.get_node("Sprite").texture = null
	obj.tile_selected = 0
	obj.get_node("Area2D").remove_child(obj.get_node("Area2D").get_child(0))
	obj.cleaning = false
	obj.enough_money = false

func check_mejoras():
	if(GameManager.currentPlayer):
		#Check mejoras de arboles
		var arboles = Array(GameManager.player['level']["Arboles"].keys())
		var count = 0
		for key in arboles:
			var is_upgraded = GameManager.player['level']["Arboles"][key]
			if(is_upgraded ):
				if("NE" in key):
					upgradeTrees("NETrees")
					count += 1
				elif("NO" in key):
					upgradeTrees("NOTrees")
					count += 1
				elif("SO" in key):
					upgradeTrees("SOTrees")
					count += 1
				elif("SE" in key):
					upgradeTrees("SETrees")
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
		GameManager.player['level']['Arboles'][upgr] = true
		GameManager.player['monedas'] -= RECOVER_TREE_PRICE
		GameManager.savePlayerMonedas(GameManager.player['monedas'])
		check_mejoras()
		showHUD()
		

func _CutsceneAnimationPlayer_play_upgrade_animation(var anim_name:String ):
	cameraCutAnimation.play(anim_name)


