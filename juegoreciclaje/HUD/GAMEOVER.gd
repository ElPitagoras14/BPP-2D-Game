extends Control

func init(score: int, maxCombo: int):
	var ScoreLabel = $HBoxContainer/score
	var maxComboLabel = $HBoxContainer/maxcombo
	var coinsLabel = $MonedaLabel
	var medalla = $medallaImg
	var SFX = $ClappingSFX
	ScoreLabel.text = str("Puntaje: ",score)
	maxComboLabel.text = str("Max Combo: ",maxCombo)
	coinsLabel.text = str("x", int(score/10))
	if score >= 600 or maxCombo >= 50:
		medalla.texture = load("res://assets/Medallas/diamante.png")
		GameManager.player.reciclaje.medallas =3
	elif score >= 300 or maxCombo >= 25:
		medalla.texture = load("res://assets/Medallas/oro.png")
		GameManager.player.reciclaje.medallas =2
	elif score >= 200 or maxCombo >= 20:
		medalla.texture = load("res://assets/Medallas/plata.png")
		GameManager.player.reciclaje.medallas =1
	elif score >= 100 or maxCombo >= 10:
		medalla.texture = load("res://assets/Medallas/bronce.png")
		GameManager.player.reciclaje.medallas =0
	GameManager.player.reciclaje.pts += score
	if score > GameManager.player.reciclaje.mejorPuntaje:
		GameManager.player.reciclaje.mejorPuntaje = score
	GameManager.player.monedas += int(score/10)
	GameManager.saveJson(GameManager.player)
	
	
	
	

func _on_RetryButton_pressed():
	get_tree().change_scene("res://juegoreciclaje/RecicleGame.tscn")


func _on_TitleButton_pressed():
	get_tree().change_scene("res://juegoreciclaje/HUD/TitleScreen.tscn")
