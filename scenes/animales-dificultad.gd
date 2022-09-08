extends Node

var fileCong = File.new()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("BGM").play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_salirmain_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	get_tree().change_scene("res://scenes/animales-tema.tscn")



func _on_NORMAL_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	leer()
	fileCong.store_string("NORMAL")
	fileCong.close()
	get_tree().change_scene("res://scenes/animales-juego.tscn")

func _on_TRIVIA_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	#get_tree().change_scene("res://scenes/animales-tema.tscn")
	leer()
	fileCong.store_string("TRIVIA")
	fileCong.close()

func leer():
	fileCong.open("res://data/juego_animales.dat", fileCong.READ_WRITE)
