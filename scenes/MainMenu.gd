extends Control

func _ready():
	pass

func _on_arbol_pressed():
	 get_tree().change_scene("res://scenes/Cartas.tscn")

func _on_animales_pressed():
	get_tree().change_scene("res://scenes/animales.tscn")

func _on_TextureButton3_pressed():
	get_tree().change_scene("res://scenes/Enciclopedia.tscn")
