extends Node
	
var card1
var card2

var isPopUp = false
var ganaArbol = false
var newGameFlag = false

signal parCartas
signal noParCartas

const userFile = "res://userData.json"

# player contiene toda la informacion dentro del json
# para que se carguen los datos en la variable player debes llamar a loadJson()
var player
var playerName
var allPlayers
var currentPlayer

func saveJson(var playerConfig):
	var file = File.new()
	file.open(userFile, File.WRITE)
	file.store_string(to_json(playerConfig))
	file.close()

func savePlayerToJson(var juego, var medallas, var puntos):
	loadJson()
	var medallasact = int(allPlayers[currentPlayer][juego]['medallas'])
	if medallasact < int(medallas):
		allPlayers[currentPlayer][juego]['medallas'] = int(medallas)
	var mejorpuntaje = int(allPlayers[currentPlayer][juego]['mejorPuntaje'])
	if int(puntos) > mejorpuntaje:
		allPlayers[currentPlayer][juego]['mejorPuntaje'] = int(puntos)
	allPlayers[currentPlayer]['monedas'] += int(int(puntos))
	allPlayers[currentPlayer][juego]['pts'] += int(puntos)
	
	saveJson(allPlayers)
	
func saveUnlockedLvl(lvl):
	loadJson()
	allPlayers[currentPlayer]['niveles'][str(lvl)] = true
	saveJson(allPlayers)

func saveCurrentPlayerPosition(var x, var y):
	loadJson()
	allPlayers[currentPlayer]["ubicacion"]["x"] = x
	allPlayers[currentPlayer]["ubicacion"]["y"] = y
	saveJson(allPlayers)

func saveLastZone(var name, var x, var y):
	loadJson()
	allPlayers[currentPlayer]["lastZone"]["name"]=name
	allPlayers[currentPlayer]["lastZone"]["x"] = x
	allPlayers[currentPlayer]["lastZone"]["y"] = y
	saveJson(allPlayers)

func getLastZone():
	loadJson()
	return allPlayers[currentPlayer]["lastZone"]

func unlockObject(var nivel):
	loadJson()
	allPlayers[currentPlayer]["niveles"][nivel]=true
	saveJson(allPlayers)

func getObjects():
	loadJson()
	var objetos=[]
	for i in allPlayers[currentPlayer]["niveles"]:
		if i!="0":
			objetos.append(allPlayers[currentPlayer]["niveles"][i])
	return objetos

func getBaseStats():
	loadJson()
	return allPlayers[currentPlayer]["base"]

func purchaseBase(var id):
	loadJson()
	allPlayers[currentPlayer]["base"][id]=true
	saveJson(allPlayers)

func saveBaseStats(var dicc):
	loadJson()
	allPlayers[currentPlayer]["base"]=dicc
	saveJson(allPlayers)

func reduceMoney(var money):
	loadJson()
	allPlayers[currentPlayer]["monedas"]-=money
	saveJson(allPlayers)

func getMoney():
	loadJson()
	if currentPlayer==null:
		return 0
	else:
		return allPlayers[currentPlayer]["monedas"]

func save_flower_level(data_array:Array):
	allPlayers[currentPlayer]['level']['Flowers'] = data_array
	saveJson(allPlayers)

func save_user_level(var data_array:Array):
	allPlayers[currentPlayer]['level']['Upgrades'] = data_array
	saveJson(allPlayers)

func savePlayerMonedas(var newQuantity):
	allPlayers[currentPlayer]['monedas'] = newQuantity
	saveJson(allPlayers)
	
func loadJson():
	var file = File.new()
	if file.file_exists(userFile):
		file.open(userFile, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			allPlayers = data
		else:
			printerr("Corrupted data!")
	else:
		printerr("No saved data!")
		
func getUnlockedLvl():
	loadJson()
	return allPlayers[currentPlayer]['niveles']

func addPlayer(var Nombre, var sprite):
	allPlayers[Nombre] = {"animales":{"medallas":0, "mejorPuntaje":0, "pts":0}, 
	"cartas":{"medallas":0, "mejorPuntaje":0, "pts":0},
	"cavado":{"medallas":0, "mejorPuntaje":0, "pts":0}, 
	"mejoras": {
	 
	},
	"niveles": {
		"0": true,
		"1": false,
		"2": false,
		"3": false,
		"4": false,
		"5": false,
		"6": false,
		"7": false
	},
	'level':{'Flowers':[],
		'Upgrades':[], 
		"Arboles": { "NETrees": false,
		 "NOTrees": false,
		 "SETrees": false,
		 "SOTrees": false
		 }
		},
	"monedas":0, "reciclaje":{"medallas":0, "mejorPuntaje":0, "pts":0},
	"ubicacion":{"x":0, "y":0},
	"lastZone":{"name":"","x":0, "y":0},
	"base":{"level":0, "decors": false, "muebles": false, "wallDecors":false,
			"utility":false,"trophy":false, "trophy-r": false, "trophy-c":false,
			"trophy-e":false, "trophy-a":false},
	"sprite":sprite}
	saveJson(allPlayers)
	
func loadPlayer(var Nombre):
	if(Nombre and allPlayers):
		player = allPlayers[Nombre]
	else:#Error de carga, de vuleta al menu
		get_tree().change_scene("res://scenes/PantallaInicio.tscn")

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
