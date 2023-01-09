extends Node

onready var BGM = get_node("BGM")
var fileCong = File.new()
var data
onready var x=0

func _ready():
	BGM.play()



func _on_TextureButton4_button_down():
	pass


func _on_JUGAR_button_down():
	get_tree().change_scene("res://juego_cavado/scenes/niveles.tscn")
