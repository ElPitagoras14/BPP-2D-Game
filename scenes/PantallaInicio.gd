extends Control

func _ready():
	get_node("BGM").play()

func _on_TextureButton_pressed():
	get_node("Click").play()
	$Popup.popup()


func _on_Button2_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.4),"timeout")
	get_tree().quit()


func _on_Button_pressed():
	get_node("Click").play()
	$Popup.hide()


func _on_Nuevo_pressed():
	pass # Replace with function body.


func _on_Cargar_pressed():
	pass # Replace with function body.
