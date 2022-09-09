extends Control


func _ready():
	pass


func _on_JUGAR_pressed():
	get_tree().change_scene("res://juegoreciclaje/RecicleGame.tscn")


func _on_Volver_pressed():
	MusicController.stop_music()
	get_tree().change_scene("res://scenes/MainMenu.tscn")
	


func _on_Instrucciones_pressed():
	get_tree().change_scene("res://juegoreciclaje/HUD/ControlesReciclaje.tscn")
