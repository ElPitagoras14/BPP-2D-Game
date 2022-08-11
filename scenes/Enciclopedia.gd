extends Control


func _ready():
	load_data()

func _on_TextureButton_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func load_data():
	var file = File.new()
	file.open("res://data/arboles_data.dat", file.READ)
	while !file.eof_reached():
		var data = file.get_csv_line()
		print(data)
	file.close()
	
