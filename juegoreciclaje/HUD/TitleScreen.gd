extends Control


func _ready():
	pass


func _on_JUGAR_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.4),"timeout")
	get_tree().change_scene("res://juegoreciclaje/RecicleGame.tscn")


func _on_Volver_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.4),"timeout")
	MusicController.stop_music()
	GameManager.player
	get_tree().change_scene("res://hubinicial/Hub/GameHub2D.tscn")
	


func _on_Instrucciones_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.4),"timeout")
	get_tree().change_scene("res://juegoreciclaje/HUD/ControlesReciclaje.tscn")
