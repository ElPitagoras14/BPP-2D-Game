extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_TextureButton4_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
	pass # Replace with function body.


func _on_TextureButton_pressed():
	get_tree().change_scene("res://scenes/Controles.tscn")
	pass # Replace with function body.


func _on_JUGAR_pressed():
	get_tree().change_scene("res://scenes/animales-dificultad.tscn")
	pass # Replace with function body.
