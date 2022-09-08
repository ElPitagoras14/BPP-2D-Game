extends Control

onready var puntajeTotalReciclaje = get_node("MarginContainer/VBoxContainer/HBoxContainer/Reciclar/HBoxContainer/puntajeTotalReciclaje");

func _ready():
	GameManager.loadJson()

func _on_TextureButton_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
