extends Control

onready var puntajeTotalReciclaje = get_node("MarginContainer/VBoxContainer/HBoxContainer/Reciclar/HBoxContainer/puntajeTotalReciclaje");

func _ready():
	GameManager.loadJson()
	get_node("BGM").play()

func _on_TextureButton_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	get_tree().change_scene("res://scenes/MainMenu.tscn")
