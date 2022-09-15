extends Control

func _ready():
	get_node("BGM").play()

func _on_Cerrar_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	get_tree().change_scene("res://scenes/Cartas-principal.tscn")
