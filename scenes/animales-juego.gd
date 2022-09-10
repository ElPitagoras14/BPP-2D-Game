extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var indice = 0
var puntaje = 0
var rondas = 1
var vidas = 3
var list_data_animales = []
var animalesdisponibles = [1,2,3,4]
onready var index

onready var puntajelbl = get_node("Puntaje")
onready var sonido = get_node("Popup/Sonido")
onready var sfx = get_node("Popup/SFX")
onready var correcto_sound = get_node("correcto_sound")
onready var nombre = get_node("Popup/MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/VBoxContainer2/Nombre")
onready var nombreCientifico = get_node("Popup/MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/VBoxContainer2/NombreCientifico")
onready var descripcion = get_node("Popup/MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/MarginContainer/RichTextLabel")
onready var imagenArbol = get_node("Popup/MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/VBoxContainer2/Arbol")
onready var Tipo = get_node("Popup/MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/VBoxContainer2/Tipo")
onready var Familia = get_node("Popup/MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/VBoxContainer2/Familia")

onready var animal1 = get_node("Animal1")
onready var animal2 = get_node("Animal2")
onready var animal3 = get_node("Animal3")
onready var animal4 = get_node("Animal4")
onready var correcto_img = get_node("correcto")
var correcto
var seleccionado

func _ready():
	$Rondas.text = str(rondas)+"/10"
	puntajelbl.text = "0"
	correcto = randi() % 4
	correcto_img.hide()
	get_node("BGM").play()
	get_node("TextureRect").texture = load("res://images//placeholder-bosque.png")
	load_data()
	generate_elec()
	mostrarInfo()
	show_img()

func show_img():
	$Ayuda.hide()
	animal1.hide()
	animal2.hide()
	animal3.hide()
	animal4.hide()
	correcto_img.show()
	correcto_sound.stream = load("res://SFX/"+str(list_data_animales[correcto][5])+".ogg")
	correcto_sound.play()
	yield(get_tree().create_timer(6.1),"timeout")
	correcto_img.hide()
	animal1.show()
	animal2.show()
	animal3.show()
	animal4.show()
	$Ayuda.show()

func load_data():
	var fileAnimales = File.new()
	var conf = File.new()
	fileAnimales.open("res://data/animales_data.dat", fileAnimales.READ)
	conf.open("res://data/juego_animales.dat", fileAnimales.READ)
	var data2 = conf.get_csv_line()
	print(data2[0])
	while !fileAnimales.eof_reached():
		var data = fileAnimales.get_csv_line()
		if data[1]=="Mamífero" && data2[0]=="MAMIFEROS":
			list_data_animales.append(data)
		else:
			if data[1]=="Ave" && data2[0]=="AVES":
				list_data_animales.append(data)
	fileAnimales.close()
	
func generate_elec():
	randomize()
	list_data_animales.shuffle()
	animal1.texture_normal = load("res://assets/animales/"+str(list_data_animales[0][5])+".png")
	animal2.texture_normal = load("res://assets/animales/"+str(list_data_animales[1][5])+".png")
	animal3.texture_normal = load("res://assets/animales/"+str(list_data_animales[2][5])+".png")
	animal4.texture_normal = load("res://assets/animales/"+str(list_data_animales[3][5])+".png")
	
func mostrarInfo():
	sonido.visible = true
	Tipo.visible = true
	Familia.visible = true
	nombreCientifico.visible = true
	
	var imagenPrincipal = load("res://assets/animales/"+str(list_data_animales[indice][5])+".png")
	nombre.text = String(list_data_animales[indice][0])
	Tipo.text = String(list_data_animales[indice][1])
	Familia.text = String(list_data_animales[indice][2])
	nombreCientifico.text = String(list_data_animales[indice][3])
	descripcion.text = String(list_data_animales[indice][4])
	imagenArbol.texture = imagenPrincipal

var rep=1
func _on_Sonido_pressed():
	rep = rep+1
	sfx.stream = load("res://SFX/"+str(list_data_animales[indice][5])+".ogg")
	if(rep%2 == 0):
		sfx.play()
	else:
		sfx.stop()

func _on_Ayuda_pressed():
	get_node("Click").play()
	$Popup.popup()

func _on_cerrarAyuda_pressed():
	sfx.stop()
	get_node("Click").play()
	$Popup.hide()

func _on_back_pressed():
	if indice > 0:
		indice -= 1
		get_node("Page").play()
		if(rep%2 == 0):
			rep = rep+1
			sfx.stop()
		mostrarInfo()

func _on_next_pressed():
	if indice < 3:
			indice += 1
			get_node("Page").play()
			if(rep%2 == 0):
				rep = rep+1
				sfx.stop()
			mostrarInfo()

func _on_Pausar_pressed():
	get_node("Click").play()
	$Pause.popup()

func _on_ResumeButton_pressed():
	get_node("Click").play()
	$Pause.hide()

func _on_QuitGame_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	get_tree().change_scene("res://scenes/GameOver_A.tscn")

func _on_Animal4_pressed():
	accion(4)
	pass # Replace with function body.
	

func _on_Animal3_pressed():
	accion(3)
	pass # Replace with function body.


func _on_Animal2_pressed():
	accion(2)
	pass # Replace with function body.


func _on_Animal1_pressed():
	accion(1)
	pass # Replace with function body.
	
func accion(n):
	for animal in animalesdisponibles:
		if(animal==1 && n!=1):
			animal1.hide()
		else:
			if(animal==2 && n!=2):
				animal2.hide()
			else:
				if(animal==3 && n!=3):
					animal3.hide()
				else:
					if(animal==4 && n!=4):
						animal4.hide()
	get_node("Node/"+str(list_data_animales[n-1][5])).play()
	yield(get_tree().create_timer(6.1),"timeout")
	if(n==1):
		animal1.hide()
		verify(1)
	else:
		if(n==2):
			animal2.hide()
			verify(2)
		else:
			if(n==3):
				animal3.hide()
				verify(3)
			else:
				if(n==4):
					animal4.hide()
					verify(4)
	for animal in animalesdisponibles:
		if(animal==1):
			animal1.show()
		else:
			if(animal==2):
				animal2.show()
			else:
				if(animal==3):
					animal3.show()
				else:
					if(animal==4):
						animal4.show()
	if(n-1==correcto):
		puntaje+=100
		puntajelbl.text = str(puntaje)
		$PopupCorrecto/VBoxContainer/Correcto_img.texture = load("res://assets/animales/"+str(list_data_animales[n-1][5])+".png")
		$PopupCorrecto/VBoxContainer/HBoxContainer/HBoxContainer/AnimalEncontrado.text = list_data_animales[n-1][0]
		$correctoSFX.play()
		$PopupCorrecto.popup()
	else:
		if(puntaje-25>0):
			puntaje-=25
		else:
			puntaje=0
		puntajelbl.text = str(puntaje)
		$incorrectoSFX2.play()
		if vidas == 0:
			var coinsLabel = $End/MonedaLabel
			var medalla = $End/medallaImg
			var SFX = $End/ClappingSFX
			$End/score.text = puntaje
			if puntaje >= 900:
				medalla.texture = load("res://assets/Medallas/diamante.png")
			elif puntaje >= 750:
				medalla.texture = load("res://assets/Medallas/oro.png")
			elif puntaje >= 500:
				medalla.texture = load("res://assets/Medallas/plata.png")
			elif puntaje >= 250:
				medalla.texture = load("res://assets/Medallas/bronce.png")
			$End.popup()
		else:
			var corazon = get_node("Corazon"+str(vidas))
			var image = Image.new()
			image.load("res://assets/iconos/heart_border.png")
			var texture = ImageTexture.new()
			texture.create_from_image(image)
			corazon.set_texture(texture)
			$PopupIncorrecto.popup()
			vidas -= 1

func verify(n):
	index = animalesdisponibles.find(n,0)
	if(index!=-1):
		animalesdisponibles.remove(index)

func restart():
	animalesdisponibles = [1,2,3,4]
	generate_elec()
	mostrarInfo()
	show_img()


func _on_PopupCorrecto_popup_hide():
	if rondas<=10:
		restart()
		rondas+=1
		$Rondas.text = str(rondas)+"/10"
	pass # Replace with function body.


func _on_RetryButton_pressed():
	pass # Replace with function body.


func _on_TitleButton_pressed():
	pass # Replace with function body.
