extends Control

var medallas = ["Bronce", "Plata", "Oro", "Diamante"]

onready var puntajeTotalReciclaje = get_node("MarginContainer/VBoxContainer/HBoxContainer/Reciclar/HBoxContainer/puntajeTotalReciclaje");
onready var puntajeTotalBosque = get_node("MarginContainer/VBoxContainer/HBoxContainer/Bosque/HBoxContainer/puntajeTotalBosque")
onready var puntajeTotalAnimals = get_node("MarginContainer/VBoxContainer/HBoxContainer/Animals/HBoxContainer/puntajeTotalAnimals")

onready var mejorPuntajeReciclaje = get_node("MarginContainer/VBoxContainer/HBoxContainer/Reciclar/HBoxContainer2/mejorPuntajeReciclaje")
onready var mejorPuntajeBosque = get_node("MarginContainer/VBoxContainer/HBoxContainer/Bosque/HBoxContainer2/mejorPuntajeBosque")
onready var mejorPuntajeAnimals = get_node("MarginContainer/VBoxContainer/HBoxContainer/Animals/HBoxContainer2/mejorPuntajeAnimals")


func _ready():
	GameManager.loadJson()
	GameManager.loadPlayer(GameManager.currentPlayer)
	$MarginContainer/VBoxContainer/JugadorActual.text = str(GameManager.currentPlayer)
	get_node("BGM").play()
	puntajeTotalReciclaje.text = str(GameManager.player.reciclaje.pts)
	puntajeTotalBosque.text = str(GameManager.player.cartas.pts)
	puntajeTotalAnimals.text = str(GameManager.player.animales.pts)
	
	mejorPuntajeReciclaje.text = str(GameManager.player.reciclaje.mejorPuntaje)
	mejorPuntajeBosque.text = str(GameManager.player.cartas.mejorPuntaje)
	mejorPuntajeAnimals.text = str(GameManager.player.animales.mejorPuntaje)
	
	#Animales
	var count = 0
	while(count < int(GameManager.player.animales.medallas)):
		var medalla = load("res://assets/Medallas/"+str(medallas[count])+".png")
		get_node("MarginContainer/VBoxContainer/HBoxContainer/Animals/medallasAnimals/"+medallas[count]).texture = medalla
		count+=1
	
	#Cartas
	count = 0
	while(count < int(GameManager.player.cartas.medallas)):
		var medalla = load("res://assets/Medallas/"+str(medallas[count])+".png")
		get_node("MarginContainer/VBoxContainer/HBoxContainer/Bosque/medallasBosque/"+medallas[count]).texture = medalla
		count+=1
		
	#Reciclaje
	count = 0
	while(count < int(GameManager.player.reciclaje.medallas)):
		var medalla = load("res://assets/Medallas/"+str(medallas[count])+".png")
		get_node("MarginContainer/VBoxContainer/HBoxContainer/Reciclar/medallasReciclaje/"+medallas[count]).texture = medalla
		count+=1
	
func _on_TextureButton_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	get_tree().change_scene("res://hubinicial/Hub/GameHub2D.tscn")
