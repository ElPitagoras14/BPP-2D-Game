extends Popup

func _ready():
	connect("popup_hide", self, "close")

func close():
	GameManager.isPopUp = false
	if GameManager.ganaArbol:
		get_tree().change_scene("res://scenes/MainMenu.tscn")
