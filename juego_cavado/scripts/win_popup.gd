extends Popup

var lbl_score
var lbl_coin

# Called when the node enters the scene tree for the first time.
func _ready():
	lbl_score = get_node("HBoxContainer/ScoreValue")
	lbl_coin = get_node("CoinValue")

func _update_values():
	var points = CavadoMaster.points
	var life_points = CavadoMaster.act_life * 30
	var energy_points = floor((CavadoMaster.max_energy - CavadoMaster.actual_energy) * 60)
	var new_points = floor((points + life_points + energy_points * (1 + CavadoMaster.nivel_actual / 20)) / 10) 
	var coins = floor(new_points / 10)
	lbl_score.text = str(new_points)
	lbl_coin.text = "x" + str(coins)
	if new_points >= 500:
		var baseStats = GameManager.getBaseStats()
		if !baseStats["trophy-e"]:
			$HBoxContainer2/VBoxContainer/Mensaje.text = "Ganaste una medalla!!!"
		baseStats["trophy-e"] = true
		GameManager.saveBaseStats(baseStats)
	GameManager.savePlayerToJson("cavado", 0, new_points)
	
func _show():
	self.set_visible(true)

func _on_ZonaCavar_win_game():
	_update_values()
	_show()
