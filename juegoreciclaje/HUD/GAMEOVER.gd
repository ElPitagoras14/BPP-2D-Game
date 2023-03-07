extends Control

func init(score: int, maxCombo: int):
	var ScoreLabel = $HBoxContainer/score
	var maxComboLabel = $HBoxContainer/maxcombo
	var coinsLabel = $MonedaLabel
	var medalla = $medallaImg
	var SFX = $ClappingSFX
	var money=int(score/10)
	ScoreLabel.text = str("Puntaje: ",score)
	maxComboLabel.text = str("Max Combo: ",maxCombo)
	coinsLabel.text = str("x", money)
	if score >= 600 or maxCombo >= 50:
		var baseStats=GameManager.getBaseStats()
		if !baseStats["trophy-r"]:
			$message.show()
		baseStats["trophy-r"]=true
		GameManager.saveBaseStats(baseStats)
		medalla.texture = load("res://assets/Medallas/diamante.png")
		if GameManager.player.reciclaje.medallas < 4:
			GameManager.player.reciclaje.medallas =4
	elif score >= 300 or maxCombo >= 25:
		medalla.texture = load("res://assets/Medallas/oro.png")
		if GameManager.player.reciclaje.medallas < 3:
			GameManager.player.reciclaje.medallas =3
	elif score >= 200 or maxCombo >= 20:
		medalla.texture = load("res://assets/Medallas/plata.png")
		if GameManager.player.reciclaje.medallas < 2:
			GameManager.player.reciclaje.medallas =2
	elif score >= 100 or maxCombo >= 10:
		medalla.texture = load("res://assets/Medallas/bronce.png")
		if GameManager.player.reciclaje.medallas < 1:
			GameManager.player.reciclaje.medallas =1
	GameManager.savePlayerToJson("reciclaje", GameManager.player.reciclaje.medallas, score)
	
	
	
	

func _on_RetryButton_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.4),"timeout")
	get_tree().change_scene("res://juegoreciclaje/RecicleGame.tscn")


func _on_TitleButton_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.4),"timeout")
	get_tree().change_scene("res://juegoreciclaje/HUD/TitleScreen.tscn")
