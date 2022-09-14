extends Control

func _ready():
	get_node("BGM").play()

func _on_arbol_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	get_tree().change_scene("res://scenes/Cartas-principal.tscn")

func _on_animales_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	get_tree().change_scene("res://scenes/animales.tscn")

func _on_Enciclopedia_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	get_tree().change_scene("res://scenes/Enciclopedia.tscn")

func _on_reciclaje_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	get_tree().change_scene("res://juegoreciclaje/HUD/TitleScreen.tscn")
	MusicController.play_music()

func _on_Cancelar4_pressed():
	get_node("Click").play()
	$SalirPopup.hide()

func _on_Salir4_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.4),"timeout")
	get_tree().change_scene("res://scenes/PantallaInicio.tscn")

func _on_Perfil_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	get_tree().change_scene("res://scenes/Perfil.tscn")

func _on_Salir5_pressed():
	get_node("Click").play()
	$SalirPopup.popup()
