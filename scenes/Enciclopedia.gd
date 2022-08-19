extends Control

var indice = 0
var list_data_arboles = []
var list_data_animales = []

var vistaActual = "Arboles"
onready var sonido = get_node("Sonido")
onready var sfx = get_node("SFX")
onready var nombre = get_node("MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/VBoxContainer2/Nombre")
onready var nombreCientifico = get_node("MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/VBoxContainer2/NombreCientifico")
onready var descripcion = get_node("MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/MarginContainer/RichTextLabel")
onready var imagenArbol = get_node("MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/VBoxContainer2/Arbol")
onready var btnArboles = get_node("MarginContainer/VBoxContainer/HBoxContainer3/HBoxContainer/Arboles")
onready var btnAnimales = get_node("MarginContainer/VBoxContainer/HBoxContainer3/HBoxContainer/Animales")
onready var Tipo = get_node("MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/VBoxContainer2/Tipo")
onready var Familia = get_node("MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/VBoxContainer2/Familia")
onready var hoja = get_node("MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Hoja")
onready var fruto = get_node("MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Fruto")
onready var flor = get_node("MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3/Flor")
onready var semilla = get_node("MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer4/Semilla")

func _ready():
	load_data()
	btnArboles.disabled = true

func _on_TextureButton_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func load_data():
	var fileArboles = File.new()
	var fileAnimales = File.new()
	indice = 0
	fileArboles.open("res://data/arboles_data.dat", fileArboles.READ)
	fileAnimales.open("res://data/animales_data.dat", fileAnimales.READ)
	
	while !fileArboles.eof_reached():
		var data = fileArboles.get_csv_line()
		if data.size() > 2:
			list_data_arboles.append(data)
			
	while !fileAnimales.eof_reached():
		var data = fileAnimales.get_csv_line()
		if data.size() > 3:
			list_data_animales.append(data)
			
	fileArboles.close()
	fileAnimales.close()
	list_data_animales.remove(0)
	list_data_arboles.remove(0)
	mostrarInfo()

func _on_back_pressed():
	if indice > 0:
		indice -= 1
		if(rep%2 == 0):
			rep = rep+1
			sfx.stop()
		mostrarInfo()

func _on_next_pressed():
	if vistaActual == "Arboles":
		if indice < list_data_arboles.size() - 1:
			indice += 1
			mostrarInfo()
	else:
		if indice < list_data_animales.size() - 1:
			indice += 1
			if(rep%2 == 0):
				rep = rep+1
				sfx.stop()
			mostrarInfo()

func mostrarInfo():
	if vistaActual == "Arboles":
		$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer.visible = true
		$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2.visible = true
		$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3.visible = true
		$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer4.visible = true
		sonido.visible = false
		Tipo.visible = false
		Familia.visible = false
		
		hoja.visible = true
		fruto.visible = true
		flor.visible = true
		semilla.visible = true
		
		var imagenPrincipal = load("res://assets/cards/"+str(list_data_arboles[indice][0])+"/arbolimg.png")
		var hojaImg = load("res://assets/cards/"+str(list_data_arboles[indice][0])+"/hoja.png")
		var frutoImg = load("res://assets/cards/"+str(list_data_arboles[indice][0])+"/fruto.png")
		var florImg = load("res://assets/cards/"+str(list_data_arboles[indice][0])+"/flor.png")
		var semillaImg = load("res://assets/cards/"+str(list_data_arboles[indice][0])+"/semilla.png")
		
		nombre.text = String(list_data_arboles[indice][0]).capitalize()
		nombreCientifico.text = "Nombre cientifico: \n" + String(list_data_arboles[indice][1]).capitalize()
		descripcion.text = String(list_data_arboles[indice][2])
		imagenArbol.texture = imagenPrincipal
		hoja.texture = hojaImg
		if frutoImg == null:
			$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2.visible = false
		else:
			$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2.visible = true
		
		fruto.texture = frutoImg
		
		if florImg == null:
			$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3.visible = false
		else:
			$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3.visible = true
		flor.texture = florImg
		semilla.texture = semillaImg
	else:
		sonido.visible = true
		Tipo.visible = true
		Familia.visible = true
		
		$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer.visible = false
		$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2.visible = false
		$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3.visible = false
		$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer4.visible = false
		
		var imagenPrincipal = load("res://assets/animales/"+str(list_data_animales[indice][5])+".png")
		nombre.text = String(list_data_animales[indice][0])
		Tipo.text = String(list_data_animales[indice][1])
		Familia.text = String(list_data_animales[indice][2])
		nombreCientifico.text = String(list_data_animales[indice][3])
		descripcion.text = String(list_data_animales[indice][4])
		imagenArbol.texture = imagenPrincipal

func _on_Arboles_pressed():
	if(rep%2 == 0):
			rep = rep+1
			sfx.stop()
	vistaActual = "Arboles"
	btnArboles.disabled = true
	btnAnimales.disabled = false
	indice = 0
	mostrarInfo()


func _on_Animales_pressed():
	if(rep%2 == 0):
			rep = rep+1
			sfx.stop()
	vistaActual = "Animales"
	btnAnimales.disabled = true
	btnArboles.disabled = false
	indice = 0
	mostrarInfo()

var rep=1
func _on_Sonido_pressed():
	rep = rep+1
	sfx.stream = load("res://SFX/"+str(list_data_animales[indice][5])+".ogg")
	#AudioStreamOGGVorbis
	if(rep%2 == 0):
		sfx.play()
	else:
		sfx.stop()
	pass # Replace with function body.
