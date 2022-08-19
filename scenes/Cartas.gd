extends Control

var deck = Array()
var pares = 0
var puntaje = 0
var vidas = 3
var totalPares
var arboles = Array()

func _ready():
	var fileArboles = File.new()
	fileArboles.open("res://data/arboles_data.dat", fileArboles.READ)
	
	while !fileArboles.eof_reached():
		var data = fileArboles.get_csv_line()
		if data.size() > 2:
			arboles.append(data[0])
	arboles.remove(0)
	fileArboles.close()
	
	fillDeck()
	dealDeck()
	var cartaNode = get_tree().get_root().find_node("GameManager", true, false)
	cartaNode.connect("parCartas", self, "handlerPar")
	cartaNode.connect("noParCartas", self, "handlerNoPar")
	totalPares = deck.size() / 2
	nuevoPuntaje()
	
func handlerPar(var value):
	pares += 1
	puntaje += 50
	nuevoPuntaje()
	GameManager.isPopUp = true
	
	if totalPares == pares:
		GameManager.ganaArbol = true
		$Gana/Popup/VBoxContainer/HBoxContainer/Puntaje.text  = str(puntaje)
		$Gana/Popup.popup()
		
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
	
	while f <= 3:
		c = 1
		while c <= 2:
			deck.append(CardObj.new("arbol", arboles[i]))
			deck.append(CardObj.new("hoja", arboles[i]))
			i+=1
			c += 1
		f += 1
	
func dealDeck():
	var c = 0
	deck.shuffle()
	while c < deck.size():
		$grid.add_child(deck[c])
		c += 1

func nuevoPuntaje():
	$MarginContainer/HBoxContainer/Puntaje.text = String(puntaje)
