extends Control

var deck = Array()
var pares = 0
var puntaje = 0
var vidas = 3
var totalPares

func _ready():
	fillDeck()
	dealDeck()
	var cartaNode = get_tree().get_root().find_node("GameManager", true, false)
	cartaNode.connect("parCartas", self, "handlerPar")
	cartaNode.connect("noParCartas", self, "handlerNoPar")
	totalPares = deck.size() / 2
	nuevoPuntaje()
	
func handlerPar():
	pares += 1
	puntaje += 10
	nuevoPuntaje()
	
	if totalPares == pares:
		$Gana/Popup/VBoxContainer/Label.text = "¡Felicidades, ha ganado!"
		$Gana/Popup/VBoxContainer/HBoxContainer/Puntaje.text  = str(puntaje)
		$Gana/Popup.popup()
	else:
		$Control/Popup.popup()

func handlerNoPar():
	if vidas == 0:
		get_tree().change_scene("res://scenes/MainMenu.tscn")
	else:
		var corazon = get_node("MarginContainer/HBoxContainer/HBoxContainer/Corazon"+str(vidas))
		var image = Image.new()
		image.load("res://assets/heart_border.png")
		var texture = ImageTexture.new()
		texture.create_from_image(image)
		corazon.set_texture(texture)
		vidas -= 1

func fillDeck():
	var c = 1
	var f = 1
	
	while f < 5:
		c = 1
		while c <= 2:
			deck.append(CardObj.new("arbol", c))
			deck.append(CardObj.new("hoja", c))
			c += 1
		f += 1
	
func dealDeck():
	var c = 0
	while c < deck.size():
		$grid.add_child(deck[c])
		c += 1

func nuevoPuntaje():
	$MarginContainer/HBoxContainer/Puntaje.text = String(puntaje)
