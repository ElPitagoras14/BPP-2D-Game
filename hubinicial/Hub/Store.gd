extends Control

onready var puntajeTotalReciclaje = get_node("MarginContainer/VBoxContainer/HBoxContainer/Reciclar/HBoxContainer/puntajeTotalReciclaje");
onready var puntajeTotalBosque = get_node("MarginContainer/VBoxContainer/HBoxContainer/Bosque/HBoxContainer/puntajeTotalBosque")
onready var puntajeTotalAnimals = get_node("MarginContainer/VBoxContainer/HBoxContainer/Animals/HBoxContainer/puntajeTotalAnimals")

func _ready():
	GameManager.loadJson()
	GameManager.loadPlayer(GameManager.currentPlayer)
	$MarginContainer/VBoxContainer/HBoxContainer2/JugadorActual.text = str(GameManager.currentPlayer)
	puntajeTotalReciclaje.text = str(GameManager.player.reciclaje.pts)
	puntajeTotalBosque.text = str(GameManager.player.cartas.pts)
	puntajeTotalAnimals.text = str(GameManager.player.animales.pts)
	
func _on_TextureButton_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	get_tree().change_scene("res://hubinicial/Hub/GameHub2D.tscn")
