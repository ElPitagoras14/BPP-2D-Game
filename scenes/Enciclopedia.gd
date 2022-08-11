extends Control

var indice = 0
var list_data = []
var vistaActual = "Arboles"
onready var nombre = get_node("MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/VBoxContainer2/Nombre")
onready var nombreCientifico = get_node("MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/VBoxContainer2/NombreCientifico")
onready var descripcion = get_node("MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/MarginContainer/RichTextLabel")

func _ready():
	load_data()

func _on_TextureButton_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func load_data():
	var file = File.new()
	list_data = []
	indice = 0
	
	if vistaActual == "Arboles":
		file.open("res://data/arboles_data.dat", file.READ)
	else:
		file.open("res://data/animales_data.dat", file.READ)
	while !file.eof_reached():
		var data = file.get_csv_line()
		if data.size() > 3:
			list_data.append(data)
	file.close()
	list_data.remove(0)
	mostrarInfo()

func _on_back_pressed():
	if indice > 0:
		indice -= 1
		mostrarInfo()

func _on_next_pressed():
	if indice < list_data.size() - 1:
		indice += 1
		mostrarInfo()

func mostrarInfo():
	nombre.text = String(list_data[indice][0])
	nombreCientifico.text = String(list_data[indice][1])
	descripcion.text = String(list_data[indice][2])


func _on_Arboles_pressed():
	vistaActual = "Arboles"
	load_data()


func _on_Animales_pressed():
	vistaActual = "Animales"
	load_data()
