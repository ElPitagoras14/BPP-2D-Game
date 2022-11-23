extends Sprite

var width
var height
var blc_width
var blc_height
var tamanio
var block_size = CavadoMaster.block_size

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _encontrado(area):
	tamanio -= 1
	if tamanio == 0:
		print("Me has encontrado")

func _set_init_data(img_size):
	width = img_size.x
	height = img_size.y
	blc_width = floor(width / block_size)
	blc_height = floor(height / block_size)
	tamanio = blc_width * blc_height
	
func _set_shape():
	var area2d = Area2D.new()
	var coll_shape = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.set_extents(Vector2(blc_width * block_size / 2, blc_height * block_size / 2))
	coll_shape.set_shape(shape)
	area2d.add_child(coll_shape)
	area2d.connect("area_exited", self, "_encontrado")
	self.add_child(area2d)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
