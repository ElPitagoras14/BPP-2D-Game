extends Control

var indice = 0
var list_data_reciclajes = []

onready var nombre = get_node("MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/VBoxContainer2/Nombre")
onready var descripcion = get_node("MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/MarginContainer/RichTextLabel")
onready var imagenArbol = get_node("MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/VBoxContainer2/Arbol")
onready var hoja = get_node("MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Hoja")
onready var fruto = get_node("MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Fruto")
onready var flor = get_node("MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3/Flor")



func _ready():
	load_data()

func _on_TextureButton_pressed():
	get_tree().current_scene.ayudaPressed()
func load_data():
	var fileReciclajes = File.new()
	indice = 0
	fileReciclajes.open("res://data/reciclajes_data.dat", fileReciclajes.READ)
			
	while !fileReciclajes.eof_reached():
		var data = fileReciclajes.get_csv_line()
		if data.size() > 1:
			list_data_reciclajes.append(data)
	fileReciclajes.close()
	list_data_reciclajes.remove(0)
	mostrarInfo()

func _on_back_pressed():
	if indice > 0:
		indice -= 1
		get_node("Page").play()
		mostrarInfo()

func _on_next_pressed():
	if indice < list_data_reciclajes.size() - 1:
		get_node("Page").play()
		indice += 1
		mostrarInfo()

func mostrarInfo():
		var imagenPrincipal = load("res://assets/reciclaje/"+list_data_reciclajes[indice][2]+".png")
		var basuraImg1 = load("res://assets/reciclaje/"+list_data_reciclajes[indice][3]+".png")
		var basuraImg2 = load("res://assets/reciclaje/"+list_data_reciclajes[indice][4]+".png")
		var basuraImg3 = load("res://assets/reciclaje/"+list_data_reciclajes[indice][5]+".png")
		hoja.texture = basuraImg1
		fruto.texture = basuraImg2
		flor.texture = basuraImg3
		nombre.text = String(list_data_reciclajes[indice][0])
		descripcion.text = String(list_data_reciclajes[indice][1])
		imagenArbol.texture = imagenPrincipal
		






