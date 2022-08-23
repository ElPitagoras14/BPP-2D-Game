extends Control

func init(score: int, maxCombo: int):
	var ScoreLabel = $ScoreLabel
	var maxComboLabel = $MaxComboLabel
	var coinsLabel = $MonedaLabel
	var medalla = $medallaImg
	var SFX = $ClappingSFX
	ScoreLabel.text = str("Score: ",score)
	maxComboLabel.text = str("Max Combo:  ", maxCombo)
	coinsLabel.text = str("x", int(score/10))
	if score >= 600 or maxCombo >= 50:
		medalla.texture = load("res://assets/Medallas/diamante.png")
	elif score >= 300 or maxCombo >= 25:
		medalla.texture = load("res://assets/Medallas/oro.png")
	elif score >= 200 or maxCombo >= 20:
		medalla.texture = load("res://assets/Medallas/plata.png")
	elif score >= 100 or maxCombo >= 10:
		medalla.texture = load("res://assets/Medallas/bronce.png")
	
	
	
	

func _on_RetryButton_pressed():
	get_tree().reload_current_scene()


func _on_TitleButton_pressed():
	get_tree().change_scene("res://juegoreciclaje/HUD/TitleScreen.tscn")
