extends Node
	
var card1
var card2
onready var Game = get_node("res://scenes/Cartas.tscn")
var isPopUp = false

signal parCartas
signal noParCartas

func _ready():
	pass
	
func chooseCard(var c):
	if card1 == null and !isPopUp:
		card1 = c
		card1.cartaSeleccionada()
		card1.set_disabled(true)
	elif card2 == null and !isPopUp:
		card2 = c
		card2.cartaSeleccionada()
		card2.set_disabled(true)
		checkCard()

func checkCard():
	if card1.value == card2.value and !card1.isBack and !card2.isBack:
		emit_signal("parCartas", card1.value)
		card1.flip()
		card2.flip()
	elif !card1.isBack and !card2.isBack:
		emit_signal("noParCartas", card1.suit, card2.suit)
	card1.set_disabled(false)
	card2.set_disabled(false)
	card1 = null
	card2 = null

var difficulty_animales
