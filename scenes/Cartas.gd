extends Control

var deck = Array()

func _ready():
	fillDeck()
	dealDeck()
	var cartaNode = get_tree().get_root().find_node("GameManager", true, false)
	cartaNode.connect("parCartas", self, "handlerPar")
	cartaNode.connect("noParCartas", self, "handlerNoPar")
	
func handlerPar():
	get_node("Label").text = "Encontró un par"

func handlerNoPar():
	get_node("Label").text = "Par incorrecto"

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

