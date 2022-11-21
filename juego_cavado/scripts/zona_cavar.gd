extends Control

var volume = []
var i;
var j;
var layers;
var g_pos;
var size;

func _ready():
	g_pos = self.rect_position
	size = self.rect_size
	_fill_scene(5, 5, 2)
	pass # Replace with function body.
	
func _fill_scene(width, height, layers):
	self.layers = layers;
	volume.resize(layers)
	for layer in range(layers):
		volume[layer] = []
		volume[layer].resize(height)
		for i in range(height):
			volume[layer][i] = []
			volume[layer][i].resize(width)
			for j in range(width):
				var spr_block = Sprite.new()
				var name_tex_block = "res://juego_cavado/assets/block-" + str(layer) + ".png"
				var tex_block = load(name_tex_block)
				spr_block.set_texture(tex_block)
				spr_block.set_position(Vector2((j + 0.5) * 75, (i + 0.5) * 75))
				var scr_block = load("res://juego_cavado/scripts/block.gd")
				spr_block.set_script(scr_block)
				add_child(spr_block)
				volume[layer][i][j] = spr_block
					
func _input(event):
	if !(event is InputEventMouseButton):
		return
	if event.button_mask != 0:
		return
	var click_pos = event.position
	if !_check_click(click_pos.x, click_pos.y):
		return
	_get_indexs(click_pos)
	for layer in range(layers - 1, -1,-1):
		if is_instance_valid(volume[layer][i][j]):
			var block = volume[layer][i][j];
			block.eliminar()
			return
			

func _get_indexs(click_pos):
	var c_x = click_pos.x
	var c_y = click_pos.y
	j = floor((c_x - g_pos.x) / 75)
	i = floor((c_y - g_pos.y) / 75)
	print(i)
	print(j)
	
func _check_click(x, y):
	if abs(x - g_pos.x) < size.x and abs(y - g_pos.y) < size.y:
		return true
	return false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
