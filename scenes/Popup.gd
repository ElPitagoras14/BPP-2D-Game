extends Popup

func _ready():
	connect("popup_hide", self, "close")

func _on_Button_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func close():
	GameManager.isPopUp = false
