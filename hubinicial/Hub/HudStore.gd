extends CanvasLayer

var monedas_temp = 0

onready var  label_monedas = $PlayerMonedas

	
func set_temp_monedas():
	GameManager.loadJson()
	GameManager.loadPlayer(GameManager.currentPlayer)
	monedas_temp = GameManager.player.monedas

func update_currency(var buy_price):
	monedas_temp = monedas_temp - buy_price
	set_label_monedas()

func set_label_monedas():
	label_monedas.text = str(monedas_temp)
	
func show_warning_msg():
	$StoreMenu.show_warning()
	
func hide_warning_msg():
	$StoreMenu.hide_warning()

