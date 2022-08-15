extends Control

func _ready():
	pass

func _on_arbol_pressed():
	 get_tree().change_scene("res://scenes/Cartas-principal.tscn")

func _on_animales_pressed():
	get_tree().change_scene("res://scenes/animales.tscn")

func _on_Enciclopedia_pressed():
	get_tree().change_scene("res://scenes/Enciclopedia.tscn")


func _on_reciclaje_pressed():
	get_tree().change_scene("res://juegoreciclaje/HUD/TitleScreen.tscn")
