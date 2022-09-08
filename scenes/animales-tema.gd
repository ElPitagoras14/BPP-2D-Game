extends Control


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

var fileCong = File.new()
var data
	
func _on_salirmod_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	get_tree().change_scene("res://scenes/animales.tscn")
	pass # Replace with function body.
	
func _on_MAMIFEROS_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	leer()
	fileCong.store_string("MAMIFEROS,")
	fileCong.close()
	get_tree().change_scene("res://scenes/animales-dificultad.tscn")

func _on_AVES_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	#get_tree().change_scene("res://scenes/animales-tema.tscn")
	leer()
	fileCong.store_string("AVES,")
	fileCong.close()
	get_tree().change_scene("res://scenes/animales-dificultad.tscn")

func leer():
	fileCong.open("res://data/juego_animales.dat", fileCong.WRITE)
	data = fileCong.get_csv_line()
	
