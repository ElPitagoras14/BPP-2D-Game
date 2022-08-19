extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var list_data_animales = []
var list_data_elec = []

# Called when the node enters the scene tree for the first time.
func _ready():
	load_data()
	generate_elec()
	
func load_data():
	var fileAnimales = File.new()
	fileAnimales.open("res://data/animales_data.dat", fileAnimales.READ)
			
	while !fileAnimales.eof_reached():
		var data = fileAnimales.get_csv_line()
		if data.size() > 3:
			list_data_animales.append(data)
			
	fileAnimales.close()
	list_data_animales.remove(0)
	
func generate_elec():
	#while(list_data_elec.size()<4):
	#	var num = (randi() % (list_data_animales.size()))
	#	if(!list_data_elec.has(num)):
	#		list_data_elec.append(num)
	#	print(list_data_elec)
	randomize()
	list_data_animales.shuffle()
		
	#var imagen1 = load("res://assets/animales/"+str(list_data_animales[list_data_elec[0]][5])+".png")
	#var imagen2 = load("res://assets/animales/"+str(list_data_animales[list_data_elec[1]][5])+".png")
	#var imagen3 = load("res://assets/animales/"+str(list_data_animales[list_data_elec[2]][5])+".png")
	#var imagen4 = load("res://assets/animales/"+str(list_data_animales[list_data_elec[3]][5])+".png")
	
	var imagen1 = load("res://assets/animales/"+str(list_data_animales[0][5])+".png")
	var imagen2 = load("res://assets/animales/"+str(list_data_animales[1][5])+".png")
	var imagen3 = load("res://assets/animales/"+str(list_data_animales[2][5])+".png")
	var imagen4 = load("res://assets/animales/"+str(list_data_animales[3][5])+".png")
	$GridContainer/Animal1/Sprite.texture = imagen1
	$GridContainer/Animal2/Sprite.texture = imagen2
	$GridContainer/Animal3/Sprite.texture = imagen3
	$GridContainer/Animal4/Sprite.texture = imagen4
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_Animal1_body_entered(body):
	print("A1")
	get_node("Node/ardilla").play()
	pass # Replace with function body.


func _on_Animal2_body_entered(body):
	print("A2")
	pass # Replace with function body.


func _on_Animal3_body_entered(body):
	print("A3")
	pass # Replace with function body.


func _on_Animal4_body_entered(body):
	print("A4")
	pass # Replace with function body.


func _on_Ayuda_pressed():
	pass # Replace with function body.
