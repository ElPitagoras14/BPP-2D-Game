extends Sprite

var block_size = CavadoMaster.block_size
var g_pos
var lbl_point

# Called when the node enters the scene tree for the first time.
func _ready():
	lbl_point = get_parent().get_parent().get_node("HUD/Puntaje")
	g_pos = self.global_position
	pass # Replace with function body.

func _input(event):
	if !(event is InputEventMouseMotion):
		return
	var click_pos = event.position
	if _check_click(click_pos.x, click_pos.y):
		set_self_modulate(Color(0.9450, 0.6862, 0.6862))
	else:
		set_self_modulate(Color(1, 1, 1))

func _eliminar():
	lbl_point._point_event(2)
	queue_free()
	
func _check_click(x, y):
	var range_x = abs(x - g_pos.x) < block_size / 2
	var range_y = abs(y - g_pos.y) < block_size / 2
	if range_x and range_y:
		return true
	return false

func _set_shape(layer):
	if layer != 0:
		return
	var area2d = Area2D.new()
	var coll_shape = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.set_extents(Vector2(block_size / 2, block_size / 2))
	coll_shape.set_shape(shape)
	area2d.add_child(coll_shape)
	self.add_child(area2d)
