extends Node
	
var card1
var card2
	
func _ready():
	pass
	
func chooseCard(var c):
	if card1 == null:
		card1 = c
		card1.cartaSeleccionada()
		card1.set_disabled(true)
	elif card2 == null:
		card2 = c
		card2.cartaSeleccionada()
		card2.set_disabled(true)
		checkCard()

func checkCard():
	if card1.value == card2.value:
		print('Par')
	else:
		print('No Par')
	card1.set_disabled(false)
	card2.set_disabled(false)
	card1 = null
	card2 = null
