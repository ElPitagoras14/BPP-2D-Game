extends Node2D

var cleaning = false
var tile_selected = 0

onready var trash_tileset = get_parent().get_node("Flowers")
onready var store_menu = get_node('../HudStore')

const WATER_FLOWER_PRICE = 50
var enough_money = false

func check_enough_currency():
	if((store_menu.monedas_temp -  WATER_FLOWER_PRICE) < 0 ):
		enough_money = false
		store_menu.show_warning_msg()
		modulate = Color(1,0,0)
	else:
		enough_money = true
		store_menu.hide_warning_msg()
		if(tile_selected > 0):
			modulate = Color(0,1,0)
		else:
			modulate = Color(1,1,1)

func _on_Area2D_body_entered(body):
	if cleaning and body.name == "Flowers" :
		check_enough_currency()
		tile_selected += 1

func _on_Area2D_body_exited(body):
	if cleaning and body.name == "Flowers" :
		tile_selected -= 1

func _process(delta):
	if cleaning :
		self.global_position = get_global_mouse_position()
		
func _input(event):
	
	check_enough_currency()
	
	if(Input.is_action_just_pressed('mb_left') and tile_selected > 0 and enough_money):
		var posx = get_global_mouse_position().x 
		var posy = get_global_mouse_position().y 
		var cellx = int(get_global_mouse_position().x / trash_tileset.get_cell_size().x) 
		var celly = int(get_global_mouse_position().y / trash_tileset.get_cell_size().y)
		
		if( sign(posx) == -1): 
			cellx -= 1 
		if( sign(posy) == -1): 
			celly -= 1 
		store_menu.update_currency(WATER_FLOWER_PRICE)
		trash_tileset.set_cell(cellx,celly,-1)
		get_parent().temp_deleted_tiles.append({"x":cellx, "y":celly})
		
		check_enough_currency()
	
