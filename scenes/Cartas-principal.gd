extends Node

func _ready():
	get_node("BGM").play()

func _on_TextureButton4_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	get_tree().change_scene("res://hubinicial/Hub/GameHub2D.tscn")

func _on_TextureButton_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	get_tree().change_scene("res://scenes/Cartas-controles.tscn")

func _on_JUGAR_pressed():
	get_node("Click").play()
	$Ayuda.popup()

func _on_Cerrar_pressed():
	$Ayuda.hide()
	get_tree().change_scene("res://scenes/Cartas.tscn")
