extends Node2D

onready var player = $Jugador
onready var playerCamera = $Jugador/Camera2D
onready var dialog = $Hud/DialogPopUp
onready var cameraCutAnimation = $CutsceneCam2D/AnimationPlayer
onready var speakerAnimation = $Hud/DialogPopUp/SpeakerSprite/SpeakerAnimation
onready var HUD = $Hud/MainHud
onready var animationTimer = $AnimationTimer

onready var TreeRegionsArray = [$SWTrees, $SETrees, $NWTrees, $NETrees]

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
		player.stopControls = true
		$CutsceneCam2D.current = true
		HUD.stopControls = true
		dialog.start()
		dialog.popup_exclusive = true
		animationTimer.start()
	else:
		$Jugador/Camera2D.current = true

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
			
			playerCamera.current = true
			player.stopControls = false
			HUD.stopControls = false
			dialog.popup_exclusive = false
			dialog.hide()
			
			
		animationTimer.start()

func _loadTreeUpgrade():
	pass

func _on_FadeInAnimation_animation_finished(anim_name):
	if(dialog.dActive):
		speakerAnimation.play("speak")
		animationTimer.start()
		

func _on_ArrowAnimation_animation_finished(anim_name):
	$Hud/DialogPopUp/Arrow.visible = false
	$Hud/DialogPopUp.remove_child($Hud/DialogPopUp/Arrow)

func _on_AnimationTimer_timeout():
	speakerAnimation.stop(true)


func _on_AreaReciclaje_body_entered(body):
	GameManager.saveCurrentPlayerPosition( player.position.x - 10 , player.position.y)
	
	MusicController.play_music()

	yield(get_tree().create_timer(.1),"timeout")
	get_tree().change_scene("res://juegoreciclaje/HUD/TitleScreen.tscn")


#Managers for overlapping TreeSprites
func _on_Dinamic_area_body_entered(body):
	body.z_index += 2

func _on_Dinamic_area_body_exited(body):
	body.z_index -= 2




