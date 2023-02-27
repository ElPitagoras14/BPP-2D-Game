extends Node2D

var current_item 
var can_place = 1
var new_selection = false
var current_price = 0
var enough_money = true
var selected_tile_id = -1

onready var user_level = get_node('../UserLevel')
onready var sprite = get_node("Sprite")
onready var buildArea = get_node("Area2Detection")
onready var store_menu = get_node('../HudStore')

func check_enough_currency():
	if((store_menu.monedas_temp - current_price) < 0 ):
		enough_money = false
		store_menu.show_warning_msg()
		modulate = Color(1,0,0)
	else:
		enough_money = true
		store_menu.hide_warning_msg()
		modulate = Color(1,1,1)

func _process(delta):
	if (current_item != null ):
		self.global_position = get_global_mouse_position()
			
		if((can_place==1) and enough_money and Input.is_action_just_pressed('mb_left')):
			
			var new_item = current_item.instance()
			user_level.add_child(new_item)
			new_item.owner = user_level
			new_item.global_position = get_global_mouse_position()
			store_menu.update_currency(current_price)
			get_parent().temp_user_objects.append(new_item)
			check_enough_currency()
		
	if(new_selection and current_item != null):
		var new_item = current_item.instance()
		sprite.scale = new_item.scale
		buildArea.add_child(new_item.get_node("Area2Detection/CollisionShape2D").duplicate())
		
		new_selection = false
		check_enough_currency()

func _on_Editor_Object_area_entered(area):
	can_place += 1
	if(can_place != 1 or not enough_money):
		modulate = Color(1,0,0)

func _on_Editor_Object_area_exited(area):
	can_place -= 1
	if(can_place == 1 and enough_money):
		modulate = Color(1,1,1)
