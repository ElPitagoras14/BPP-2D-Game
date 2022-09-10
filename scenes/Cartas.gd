extends Control

var deck = Array()
var pares = 0
var puntaje = 0
var vidas = 3
var totalPares
var arboles = Array()
var gameMode = "hoja"
onready var gridPane = $grid

var list_data_arboles = []
var indice = 0

func _ready():
	gameMode = "hoja"
	GameManager.ganaArbol = false
	GameManager.isPopUp = false
	var fileArboles = File.new()
	fileArboles.open("res://data/arboles_data.dat", fileArboles.READ)
	
	while !fileArboles.eof_reached():
		var data = fileArboles.get_csv_line()
		if data.size() > 2:
			arboles.append(data[0])
			list_data_arboles.append(data)
	arboles.remove(0)
	list_data_arboles.remove(0)
	fileArboles.close()
	
	fillDeck()
	dealDeck()
	var cartaNode = get_tree().get_root().find_node("GameManager", true, false)
	cartaNode.connect("parCartas", self, "handlerPar")
	cartaNode.connect("noParCartas", self, "handlerNoPar")
	totalPares = deck.size() / 2
	nuevoPuntaje()
	get_node("BGM").play()
	
func handlerPar(var value):
	pares += 1
	puntaje += 50
	nuevoPuntaje()
	GameManager.isPopUp = true
	
	if totalPares == pares:
		GameManager.ganaArbol = true
		$PopupGana/VBoxContainer/HBoxContainer/Puntaje.text  = str(puntaje)
		$PopupGana.popup()
		
	else:
		var arbol = load("res://assets/cards/"+str(value)+"/arbol.png")
		$ParEncontrado/Popup/VBoxContainer/HBoxContainer/Puntos.text = "+50 puntos"
		$ParEncontrado/Popup/VBoxContainer/HBoxContainer/HBoxContainer/ArbolEncontrado.text = str(value).capitalize()
		$ParEncontrado/Popup/VBoxContainer/ArbolEncontradoImg.texture = arbol
		$ParEncontrado/Popup.popup()

func handlerNoPar(var suit1, var suit2):
	if vidas == 0:
		GameManager.ganaArbol = true
		$ParNoEncontrado/Popup/VBoxContainer/Label.text = "Perdiste todas tus vidas"
		$ParNoEncontrado/Popup/VBoxContainer/HBoxContainer.visible = false
		$ParNoEncontrado/Popup.popup()
	else:
		var corazon = get_node("MarginContainer/HBoxContainer/HBoxContainer/Corazon"+str(vidas))
		var image = Image.new()
		image.load("res://assets/iconos/heart_border.png")
		var texture = ImageTexture.new()
		texture.create_from_image(image)
		corazon.set_texture(texture)
		$ParNoEncontrado/Popup.popup()
		vidas -= 1

func fillDeck():
	var c = 1
	var f = 1
	var i = 0
	
	while f <= 1:
		c = 1
		while c <= 6:
			deck.append(CardObj.new("arbol", arboles[i]))
			deck.append(CardObj.new(gameMode, arboles[i]))
			i+=1
			c += 1
		f += 1
	
func dealDeck():
	var c = 0
	deck.shuffle()
	while c < deck.size():
		gridPane.add_child(deck[c])
		c += 1

func nuevoPuntaje():
	$MarginContainer/HBoxContainer/Puntaje.text = String(puntaje)


func _on_Button2_pressed():
	if gameMode == "hoja":
		cleanGrid()
		pares = 0
		gameMode = "semilla"
		GameManager.ganaArbol = false
		GameManager.isPopUp = false
		fillDeck()
		dealDeck()
		$PopupGana.hide()
	elif gameMode == "semilla":
		cleanGrid()
		pares = 0
		gameMode = "flor"
		GameManager.ganaArbol = false
		GameManager.isPopUp = false
		fillDeck()
		dealDeck()
		$PopupGana.hide()
	else:
		$PopupGana.hide()
		$Final.popup()
		menuFinal()
		
func cleanGrid():
	for n in gridPane.get_children():
			gridPane.remove_child(n)
			n.queue_free()


func _on_Help_pressed():
	get_node("Click").play()
	$Ayuda.popup()
	mostrarInfo()


func _on_cerrarAyuda_pressed():
	get_node("Click").play()
	$Ayuda.hide()


func _on_back_pressed():
	if indice > 0:
		indice -= 1
		get_node("Page").play()
		mostrarInfo()


func _on_next_pressed():
	if indice < arboles.size() - 1:
		indice += 1
		get_node("Page").play()
		mostrarInfo()

func mostrarInfo():
	print(list_data_arboles)
	var imagenPrincipal = load("res://assets/cards/"+str(list_data_arboles[indice][0])+"/arbolimg.png")
	var hojaImg = load("res://assets/cards/"+str(list_data_arboles[indice][0])+"/hoja.png")
	var frutoImg = load("res://assets/cards/"+str(list_data_arboles[indice][0])+"/fruto.png")
	var florImg = load("res://assets/cards/"+str(list_data_arboles[indice][0])+"/flor.png")
	var semillaImg = load("res://assets/cards/"+str(list_data_arboles[indice][0])+"/semilla.png")
	
	$Ayuda/MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/VBoxContainer2/Nombre.text = list_data_arboles[indice][0]
	$Ayuda/MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/VBoxContainer2/Tipo.text = list_data_arboles[indice][1]
	$Ayuda/MarginContainer/VBoxContainer/HBoxContainer/CenterContainer/VBoxContainer2/Arbol.texture = imagenPrincipal
	$Ayuda/MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/MarginContainer/RichTextLabel.text = list_data_arboles[indice][2]
	
	$Ayuda/MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Hoja.texture = hojaImg
	$Ayuda/MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Fruto.texture = frutoImg
	$Ayuda/MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer4/Semilla.texture = semillaImg
	$Ayuda/MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3/Flor.texture = florImg
	
	if frutoImg == null:
		$Ayuda/MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2.visible = false
		$Ayuda/MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3.visible = true
	else:
		$Ayuda/MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3.visible = false
		$Ayuda/MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2.visible = true
			

func _on_ResumeButton_pressed():
	get_node("Click").play()
	$Pause.hide()

func _on_QuitGame_pressed():
	get_node("Click").play()
	$Final.popup()
	menuFinal()

func _on_Pause_pressed():
	get_node("Click").play()
	$Pause.popup()

func menuFinal():
	$Final/Background/CenterContainer/VBoxContainer/HBoxContainer/puntajeFinal.text = str(puntaje)
	$Final/Background/CenterContainer/VBoxContainer/HBoxContainer2/monedas.text = "x"+str(floor(puntaje/50))
func _on_volverInicio_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
