extends Control

func _ready():
	get_node("BGM").play()

func _on_Button2_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.4),"timeout")
	get_tree().quit()

func _on_Button_pressed():
	get_node("Click").play()
	$Popup.hide()

func _on_Nuevo_pressed():
	get_node("Click").play()
	$Nombre.popup()

func _on_Cargar_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.4),"timeout")
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func _on_Cerrar_pressed():
	get_node("Click").play()
	$Popup.popup()

func _on_Cerrar2_pressed():
	get_node("Click").play()
	$Seleccionar.hide()
	$Nombre.popup()

func _on_Cerrar3_pressed():
	get_node("Click").play()
	$Nombre.hide()

func _on_Continuar_pressed():
	get_node("Click").play()
	$Seleccionar.popup()
