extends Control
var pGameOver := preload("res://juegoreciclaje/HUD/GAMEOVER.tscn")
onready var scoreLabel := $Puntaje
onready var comboLabel := $Rondas

var score: int = 0
var combo: int = 0
var comboExclamation: String = ""
var maxCombo: int = 0
var yellowTrash = true
var blackTrash = true



func _ready():
	Signals.connect("on_player_life_changed", self, "_on_player_life_changed")
	Signals.connect("on_score_increment", self, "_on_score_increment")
	Signals.connect("on_combo_increment",self, "_on_combo_increment")
	Signals.connect("on_combo_break",self,"_on_combo_break")
	Signals.connect("on_game_over",self,"_on_game_over")




func _on_score_increment(amount: int):
	score += amount
	scoreLabel.text = str(score)
	if score == 40 and yellowTrash:
		Signals.emit_signal("on_yellowtrash_spawn")
		yellowTrash = false
	if score == 60 and blackTrash:
		Signals.emit_signal("on_blacktrash_spawn")
		blackTrash = false
	
func _on_combo_increment():
	combo +=1
	if combo > 20:
		comboExclamation = "!!!"
	elif combo > 10:
		comboExclamation = "!!"
	elif combo > 5:
		comboExclamation = "!"
	comboLabel.text = str(combo, comboExclamation)
	
func _on_combo_break():
	if combo >= maxCombo:
		maxCombo = combo
	combo = 0
	comboExclamation = ""
	comboLabel.text = str(combo)
	
func _on_game_over():
	var gameOver = pGameOver.instance()
	if combo >= maxCombo:
		maxCombo = combo
	gameOver.init(score, maxCombo)
	get_tree().current_scene.add_child(gameOver)
	queue_free() 

func _on_player_life_changed(life):
	var corazon = get_node("Corazon"+str(life))
	var image = Image.new()
	image.load("res://assets/iconos/heart_border.png")
	var texture = ImageTexture.new()
	texture.create_from_image(image)
	corazon.set_texture(texture)

func _on_Pausar_pressed():
	Signals.emit_signal("pausePressed")




func _on_Ayuda_pressed():
	Signals.emit_signal("ayudaPressed")
