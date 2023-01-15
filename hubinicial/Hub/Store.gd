extends Control

const FOURTH_UPGRADE_PRICE = 1000
const THIRD_UPGRADE_PRICE = 700
const SECOND_UPGRADE_PRICE = 500
const FIRST_UPGRADE_PRICE = 300
onready var container_upgrades = $MarginContainer/VBoxContainer/MejorasHBox

onready var level1_upgrade_buttons = [container_upgrades.get_node('Bosque/ArbolesNorEsteBox/ArbolNEButton'),\
container_upgrades.get_node('Reciclaje/ReciclajeNorEsteBox/ReciclajeNEButton'),\
container_upgrades.get_node('Animales/AnimalesNorEsteBox/AnimalesNEButton'), 
]

onready var level2_upgrade_buttons = [container_upgrades.get_node('Bosque/ArbolesNorOesteBox/ArbolNOButton'),\
container_upgrades.get_node('Reciclaje/ReciclajeNorOesteBox/ReciclajeNOButton'),\
container_upgrades.get_node('Animales/AnimalesNorOesteBox/AnimalesNOButton')
]

onready var level3_upgrade_buttons = [container_upgrades.get_node('Bosque/ArbolesSurEsteBox/ArbolSEButton'),\
container_upgrades.get_node('Reciclaje/ReciclajeSurEsteBox/ReciclajeSEButton'),\
container_upgrades.get_node('Animales/AnimalesSurEsteBox/AnimalesSEButton')
]

onready var level4_upgrade_buttons= [container_upgrades.get_node('Bosque/ArbolesSurOesteBox/ArbolSOButton'),\
container_upgrades.get_node('Reciclaje/ReciclajeSurOesteBox/ReciclajeSOButton'),\
container_upgrades.get_node('Animales/AnimalesSurOesteBox/AnimalesSOButton')
]

func _ready():
	GameManager.loadJson()
	GameManager.loadPlayer(GameManager.currentPlayer)
	$MarginContainer/VBoxContainer/HBoxContainer2/JugadorActual.text = str(GameManager.currentPlayer)
	$MarginContainer/VBoxContainer/HBoxContainer2/MonedasPlayer.text = str(GameManager.player['monedas'])
	
#	if(GameManager.player['monedas'] < FOURTH_UPGRADE_PRICE):
#		for button in level4_upgrade_buttons:
#			button.disabled 
#
#	if(GameManager.player['monedas'] < THIRD_UPGRADE_PRICE):
#		for button in level3_upgrade_buttons:
#			button.disabled = true		
#	if(GameManager.player['monedas'] < SECOND_UPGRADE_PRICE):
#		for button in level2_upgrade_buttons:
#			button.disabled = true		
#	if(GameManager.player['monedas'] < FIRST_UPGRADE_PRICE):
#		for button in level1_upgrade_buttons:
#			button.disabled = true		
	
	
func _on_TextureButton_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	get_tree().change_scene("res://hubinicial/Hub/GameHub2D.tscn")


