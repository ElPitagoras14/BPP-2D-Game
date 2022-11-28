extends Popup

var lbl_score
var lbl_coin

# Called when the node enters the scene tree for the first time.
func _ready():
	lbl_score = get_node("HBoxContainer/ScoreValue")
	lbl_coin = get_node("CoinValue")

func _update_values():
	lbl_score.text = "Hola"
	lbl_coin.text = "x" + str(2)
	
func _show():
	self.set_visible(true)

func _on_ZonaCavar_win_game():
	_update_values()
	_show()
