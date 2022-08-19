extends Control






func _on_JUGAR_pressed():
	get_tree().change_scene("res://juegoreciclaje/RecicleGame.tscn")


func _on_Volver_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
