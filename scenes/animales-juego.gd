extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var indice = 0
var list_data_animales = []
var list_data_elec = []

onready var sonido = get_node("Popup/Sonido")
onready var sfx = get_node("Popup/SFX")
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
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("BGM").play()
	get_node("TextureRect").texture = load("res://images//placeholder-bosque.png")
	load_data()
	generate_elec()
	mostrarInfo()
	
func load_data():
	var fileAnimales = File.new()
	fileAnimales.open("res://data/animales_data.dat", fileAnimales.READ)
			
	while !fileAnimales.eof_reached():
		var data = fileAnimales.get_csv_line()
		if data[1]=="Mamífero":
			list_data_animales.append(data)
			
	fileAnimales.close()
	
func generate_elec():
	#while(list_data_elec.size()<4):
	#	var num = (randi() % (list_data_animales.size()))
	#	if(!list_data_elec.has(num)):
	#		list_data_elec.append(num)
	#	print(list_data_elec)
	randomize()
	list_data_animales.shuffle()
		
	#var imagen1 = load("res://assets/animales/"+str(list_data_animales[list_data_elec[0]][5])+".png")
	#var imagen2 = load("res://assets/animales/"+str(list_data_animales[list_data_elec[1]][5])+".png")
	#var imagen3 = load("res://assets/animales/"+str(list_data_animales[list_data_elec[2]][5])+".png")
	#var imagen4 = load("res://assets/animales/"+str(list_data_animales[list_data_elec[3]][5])+".png")
	
	var imagen1 = load("res://assets/animales/"+str(list_data_animales[0][5])+".png")
	var imagen2 = load("res://assets/animales/"+str(list_data_animales[1][5])+".png")
	var imagen3 = load("res://assets/animales/"+str(list_data_animales[2][5])+".png")
	var imagen4 = load("res://assets/animales/"+str(list_data_animales[3][5])+".png")
	animal1.texture_normal = imagen1
	animal2.texture_normal = imagen2
	animal3.texture_normal = imagen3
	animal4.texture_normal = imagen4
	
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
	#AudioStreamOGGVorbis
	if(rep%2 == 0):
		sfx.play()
	else:
		sfx.stop()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_Animal1_body_entered(body):
	print("A1")
	get_node("Node/ardilla").play()
	pass # Replace with function body.


func _on_Ayuda_pressed():
	get_node("Click").play()
	$Popup.popup()
	pass # Replace with function body.

func _on_cerrarAyuda_pressed():
	sfx.stop()
	get_node("Click").play()
	$Popup.hide()
	pass # Replace with function body.


func _on_back_pressed():
	
	if indice > 0:
		indice -= 1
		get_node("Page").play()
		if(rep%2 == 0):
			rep = rep+1
			sfx.stop()
		mostrarInfo()
	pass # Replace with function body.


func _on_next_pressed():
	
	if indice < 3:
			indice += 1
			get_node("Page").play()
			if(rep%2 == 0):
				rep = rep+1
				sfx.stop()
			mostrarInfo()
	pass # Replace with function body.


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
	pass # Replace with function body.
