extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.loadJson()
	if GameManager.currentPlayer:
		$NombreJugador.text = str(GameManager.currentPlayer)

func _input(ev):
	if ($HBoxContainer.visible and Input.is_action_pressed("ui_cancel") and not ev.is_echo()):
		$HBoxContainer.visible = false
	elif ($SalirPopup.visible and Input.is_action_pressed("ui_cancel")  and not ev.is_echo() ):
		$SalirPopup.visible = false 
	elif(Input.is_action_pressed("ui_cancel")  and not ev.is_echo() ):
		$SalirPopup.popup()


func _on_Arbol_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	get_tree().change_scene("res://scenes/Cartas-principal.tscn")

func _on_Animales_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	get_tree().change_scene("res://scenes/animales.tscn")

func _on_Enciclopedia_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	get_tree().change_scene("res://scenes/Enciclopedia.tscn")

func _on_Reciclaje_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	get_tree().change_scene("res://juegoreciclaje/HUD/TitleScreen.tscn")
	MusicController.play_music()
	
func _on_ProfileButton_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	get_tree().change_scene("res://scenes/Perfil.tscn")

func _on_Menu_pressed():
	get_node("Click").play()
	
	$HBoxContainer.visible = !$HBoxContainer.visible
	$MenuBg.visible = !$MenuBg.visible

func _on_Tienda_pressed():
	pass # Replace with function body.

func _on_Exit_pressed():
	get_node("Click").play()	
	$SalirPopup.visible = !$SalirPopup.visible
	
func _on_SalirMenu_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.4),"timeout")
	get_tree().change_scene("res://scenes/PantallaInicio.tscn")

func _on_SalirJuego_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.4),"timeout")
	get_tree().quit()


func _on_Cancelar4_pressed():
	get_node("Click").play()
	$SalirPopup.visible = false
