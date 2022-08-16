extends Control

func init(score: int, maxCombo: int):
	var ScoreLabel = $ScoreLabel
	var maxComboLabel = $MaxComboLabel
	var coinsLabel = $MonedaLabel
	ScoreLabel.text = str("Score: ",score)
	maxComboLabel.text = str("Max Combo:  ", maxCombo)
	coinsLabel.text = str("x", int(score/10))
	

	
	
	

func _on_RetryButton_pressed():
	get_tree().reload_current_scene()


func _on_TitleButton_pressed():
	get_tree().change_scene("res://juegoreciclaje/HUD/TitleScreen.tscn")
