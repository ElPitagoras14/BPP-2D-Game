extends Node
	
var card1
var card2

var isPopUp = false
var ganaArbol = false

signal parCartas
signal noParCartas

const userFile = "res://userData.json"

# player contiene toda la informacion dentro del json
# para que se carguen los datos en la variable player debes llamar a loadJson()
var player

func saveJson(var playerConfig):
	var file = File.new()
	file.open(userFile, File.WRITE)
	file.store_string(to_json(playerConfig))
	file.close()

func loadJson():
	var file = File.new()
	if file.file_exists(userFile):
		file.open(userFile, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			player = data
		else:
			printerr("Corrupted data!")
	else:
		printerr("No saved data!")


func _ready():
	loadJson()
	
func chooseCard(var c):
	if card1 == null: #and !isPopUp:
		card1 = c
		card1.cartaSeleccionada()
		card1.set_disabled(true)
	elif card2 == null: #and !isPopUp:
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
		card1.backToNormal()
		card2.backToNormal()
	card1.set_disabled(false)
	card2.set_disabled(false)
	card1 = null
	card2 = null
