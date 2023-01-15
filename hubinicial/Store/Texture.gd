extends TextureRect

export (PackedScene) var this_scene

onready var object_cursor = get_node("/root/GameHub2D/Editor_Object")

onready var cursor_sprite = object_cursor.get_node("Sprite")

export var price:int

func _item_clicked(event):
	if(event is InputEvent):
		if(event.is_action_pressed("mb_left")):
			object_cursor.current_item = this_scene
			cursor_sprite.texture = texture
			object_cursor.new_selection = true
			object_cursor.current_price = price
