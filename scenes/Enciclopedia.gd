extends Control

var indice = 0
var list_data_arboles = []
var list_data_animales = []
var list_data_reciclajes = []

var vistaActual = "Arboles"
onready var sonido = get_node("Sonido")
onready var sfx = get_node("SFX")
onready var nombre = get_node("MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/VBoxContainer2/Nombre")
onready var nombreCientifico = get_node("MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/VBoxContainer2/NombreCientifico")
onready var descripcion = get_node("MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/MarginContainer/RichTextLabel")
onready var imagenArbol = get_node("MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/VBoxContainer2/Arbol")
onready var btnArboles = get_node("MarginContainer/VBoxContainer/HBoxContainer3/HBoxContainer/Arboles")
onready var btnAnimales = get_node("MarginContainer/VBoxContainer/HBoxContainer3/HBoxContainer/Animales")
onready var btnReciclaje = get_node("MarginContainer/VBoxContainer/HBoxContainer3/HBoxContainer/Reciclajes")
onready var Tipo = get_node("MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/VBoxContainer2/Tipo")
onready var Familia = get_node("MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/VBoxContainer2/Familia")
onready var hoja = get_node("MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Hoja")
onready var fruto = get_node("MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Fruto")
onready var flor = get_node("MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3/Flor")
onready var semilla = get_node("MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer4/Semilla")


func _ready():
	get_node("BGM").play()
	load_data()
	btnArboles.disabled = true

func _on_TextureButton_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	get_tree().change_scene("res://hubinicial/Hub/GameHub2D.tscn")

func load_data():
	var fileArboles = File.new()
	var fileAnimales = File.new()
	var fileReciclajes = File.new()
	indice = 0
	fileArboles.open("res://data/arboles_data.dat", fileArboles.READ)
	fileAnimales.open("res://data/animales_data.dat", fileAnimales.READ)
	fileReciclajes.open("res://data/reciclajes_data.dat", fileReciclajes.READ)
	
	while !fileArboles.eof_reached():
		var data = fileArboles.get_csv_line()
		if data.size() > 2:
			list_data_arboles.append(data)
			
	while !fileAnimales.eof_reached():
		var data = fileAnimales.get_csv_line()
		if data.size() > 3:
			list_data_animales.append(data)
			
	while !fileReciclajes.eof_reached():
		var data = fileReciclajes.get_csv_line()
		if data.size() > 1:
			list_data_reciclajes.append(data)
	
			
	fileArboles.close()
	fileAnimales.close()
	fileReciclajes.close()
	list_data_animales.remove(0)
	list_data_arboles.remove(0)
	list_data_reciclajes.remove(0)
	mostrarInfo()

func _on_back_pressed():
	if indice > 0:
		indice -= 1
		get_node("Page").play()
		if(rep%2 == 0):
			rep = rep+1
			sfx.stop()
		mostrarInfo()

func _on_next_pressed():
	if vistaActual == "Arboles":
		if indice < list_data_arboles.size() - 1:
			get_node("Page").play()
			indice += 1
			mostrarInfo()
	elif vistaActual == "Animales":
		if indice < list_data_animales.size() - 1:
			indice += 1
			get_node("Page").play()
			if(rep%2 == 0):
				rep = rep+1
				sfx.stop()
			mostrarInfo()
	elif vistaActual == "Reciclaje":
		if indice < list_data_reciclajes.size() - 1:
			get_node("Page").play()
			indice += 1
			mostrarInfo()

func mostrarInfo():
	if vistaActual == "Arboles":
		$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer.visible = true
		$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Label.text = "Hoja"
		$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2.visible = true
		$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Label.visible = true
		$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Label.text = "Fruto"
		$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3.visible = true
		$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3/Label.text = "Flor"
		$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer4.visible = true
		sonido.visible = false
		Tipo.visible = false
		Familia.visible = false
		
		hoja.visible = true
		fruto.visible = true
		flor.visible = true
		semilla.visible = true
		nombreCientifico.visible = true
		
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
	elif vistaActual == "Animales":
		sonido.visible = true
		Tipo.visible = true
		Familia.visible = true
		hoja.visible = false
		fruto.visible = false
		flor.visible = false
		semilla.visible = false
		nombreCientifico.visible = true
		
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
	elif vistaActual == "Reciclaje":
		sonido.visible = false
		Familia.visible = false
		Tipo.visible = false
		nombreCientifico.visible = false

		semilla.visible = false
		$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer.visible = true
		$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Label.text = ""
		$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2.visible = true
		$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Label.visible = true
		$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Label.text = "Ejemplos"
		$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3.visible = true
		$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3/Label.text = ""
		$MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer4.visible = false
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
		

func _on_Arboles_pressed():
	get_node("Click").play()
	if(rep%2 == 0):
			rep = rep+1
			sfx.stop()
	vistaActual = "Arboles"
	btnArboles.disabled = true
	btnAnimales.disabled = false
	btnReciclaje.disabled = false
	indice = 0
	mostrarInfo()


func _on_Animales_pressed():
	get_node("Click").play()
	if(rep%2 == 0):
			rep = rep+1
			sfx.stop()
	vistaActual = "Animales"
	btnAnimales.disabled = true
	btnArboles.disabled = false
	btnReciclaje.disabled = false
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


func _on_Reciclajes_pressed():
	get_node("Click").play()
	if(rep%2 == 0):
			rep = rep+1
			sfx.stop()
	vistaActual = "Reciclaje"
	btnReciclaje.disabled = true
	btnArboles.disabled = false
	btnAnimales.disabled = false
	indice = 0
	mostrarInfo()
