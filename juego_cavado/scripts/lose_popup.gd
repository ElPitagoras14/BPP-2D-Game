extends Popup


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var lbl_score
var lbl_coin

# Called when the node enters the scene tree for the first time.
func _ready():
	lbl_score = get_node("HBoxContainer/ScoreValue")
	lbl_coin = get_node("CoinValue")
	pass # Replace with function body.
	
func _show():
	self.set_visible(true)

func _update_values():
	var points = CavadoMaster.points
	var coins = floor(points/10)
	lbl_score.text = str(points)
	lbl_coin.text = "x" + str(coins)


func _on_ZonaCavar_lose_game():
	_update_values()
	_show()
