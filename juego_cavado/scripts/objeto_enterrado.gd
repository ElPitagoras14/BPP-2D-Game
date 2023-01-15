extends Sprite

var width
var height
var blc_width
var blc_height
var size
var block_size = CavadoMaster.block_size
var lbl_obj
var lbl_point

# Called when the node enters the scene tree for the first time.
func _ready():
	lbl_point = get_parent().get_parent().get_node("HUD/Puntaje")
	lbl_obj = get_parent().get_parent().get_node("HUD/Objeto")
	pass # Replace with function body.
	
func _encontrado(area):
	size -= 1
	if size == 0:
		lbl_point._point_event(15)
		lbl_obj._found_object()

func _set_init_data(img_size):
	width = img_size.x
	height = img_size.y
	blc_width = floor(width / block_size)
	blc_height = floor(height / block_size)
	size = blc_width * blc_height
	
func _set_shape():
	var area2d = Area2D.new()
	var coll_shape = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.set_extents(Vector2(blc_width * block_size / 2 - 5, blc_height * block_size / 2 - 5))
	coll_shape.set_shape(shape)
	area2d.add_child(coll_shape)
	area2d.connect("area_exited", self, "_encontrado")
	self.add_child(area2d)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
