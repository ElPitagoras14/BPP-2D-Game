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


func _on_TextureButton2_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	get_tree().change_scene("res://scenes/Perfil.tscn")


func _on_TextureButton_pressed():
	get_node("Click").play()
	$Popup.popup()


func _on_Button2_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.4),"timeout")
	get_tree().quit()


func _on_Button_pressed():
	get_node("Click").play()
	$Popup.hide()

