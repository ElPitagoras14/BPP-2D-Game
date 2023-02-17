extends Control
signal reduce_energy
signal win_game
signal lose_game

var objects = []
var volume = []
var column
var row

var layers
var width
var height
var act_obj_path
var num_objs

var rng = RandomNumberGenerator.new()
var g_pos
var size

var offset_x
var offset_y

var nivel_actual = CavadoMaster.nivel_actual
var block_size = CavadoMaster.block_size;
var base_path = "res://juego_cavado"
var block_path = "/assets/blocks"
var object_path = "/assets/objects"
var scr_path = "/scripts"
var prefix_obj = "/obj-"

func _ready():
	rng.randomize()
	_get_info()
	_set_default_values()
	_add_objects()
	_fill_scene()
	CavadoMaster.tool_act = "hacha"
	get_parent().get_node("AudioStreamPlayer").play()
	
func _fill_scene():
	var script = load(base_path + scr_path + "/block.gd")
	volume.resize(layers)
	for layer in range(layers):
		volume[layer] = []
		volume[layer].resize(width)
		for i in range(width):
			volume[layer][i] = []
			volume[layer][i].resize(height)
			for j in range(height):
				var block_pos_y = _get_real_pos(j, block_size, block_size, offset_y)
				var block_pos_x = _get_real_pos(i, block_size, block_size, offset_x)
				var block = _get_new_block(block_pos_x, block_pos_y, layer, script)
				block._set_shape(layer)
				add_child(block, true)
				volume[layer][i][j] = block
	
func _get_real_pos(index, blc_size, img_size, offset):
	return index * blc_size + img_size / 2 + offset

func _get_new_block(pos_x, pos_y, tex_num, script):
	var spr_block = Sprite.new()
	var name_tex_block = base_path + block_path + "/block-" + str(tex_num) + ".png"
	var tex_block = load(name_tex_block)
	spr_block.set_texture(tex_block)
	spr_block.set_position(Vector2(pos_x, pos_y))
	spr_block.set_script(script)
	return spr_block
					
func _input(event):
	if !(event is InputEventMouseButton):
		return
	if event.button_mask != 0:
		return
	var click_pos = event.position
	if !_check_click(click_pos.x, click_pos.y):
		return
	_get_indexs(click_pos)
	_delete_block()

func _delete_block():
	var tool_act = CavadoMaster.tool_act
	CavadoMaster.game_state = 0
	if tool_act == "pico":
		if _delete_stack_block():
			_delete_random_blocks(2)
			_reduce_energy(5)
	elif tool_act == "hacha":
		if _delete_single_block():
			_reduce_energy(2)
	yield(get_tree().create_timer(0.2), "timeout")
	CavadoMaster.game_state = 1
	_check_final_state()

func _reduce_energy(energy):
	var new_energy = CavadoMaster.actual_energy - energy
	if new_energy < 0:
		new_energy = 0
	CavadoMaster.actual_energy = new_energy
	emit_signal("reduce_energy")

func _delete_single_block():
	for layer in range(layers - 1, -1,-1):
		if is_instance_valid(volume[layer][column][row]):
			var block = volume[layer][column][row];
			block._eliminar()
			return true
	return false

func _delete_stack_block():
	var deleted = 0
	for layer in range(layers - 1, -1,-1):
		if is_instance_valid(volume[layer][column][row]):
			var block = volume[layer][column][row];
			block._eliminar()
			deleted += 1
	return deleted != 0
	
func _delete_random_blocks(number):
	var deleted = 0
	while(deleted != number):
		column = rng.randi_range(0, width - 1)
		row = rng.randi_range(0, height - 1)
		if _delete_single_block():
			deleted += 1

func _get_indexs(click_pos):
	var c_x = click_pos.x
	var c_y = click_pos.y
	column = floor((c_x - g_pos.x - offset_x) / block_size)
	row = floor((c_y - g_pos.y - offset_y) / block_size)
	
func _set_default_values():
	CavadoMaster.max_objects = num_objs
	CavadoMaster.game_state = 1
	CavadoMaster.act_life = 3
	CavadoMaster.actual_energy = CavadoMaster.max_energy
	CavadoMaster.actual_objects = 0
	CavadoMaster.points = 0
	
func _get_info():
	g_pos = self.rect_position
	size = self.rect_size
	var info = CavadoMaster.niveles[nivel_actual]
	width = info[0]
	height = info[1]
	layers = info[2]
	act_obj_path = info[3]
	num_objs = info[4]
	offset_x = (size.x - width * block_size) / 2
	offset_y = (size.y - height * block_size) / 2
	
func _check_click(x, y):
	if (CavadoMaster.game_state == 0):
		return false
	var range_x = abs(x - g_pos.x - offset_x) < (width * block_size)
	var range_y = abs(y - g_pos.y - offset_y) < (height * block_size)
	if range_x and range_y:
		return true
	return false
	
func _add_objects():
	objects.resize(width)
	for i in range(width):
		objects[i] = []
		objects[i].resize(height)
		for j in range(height):
			objects[i][j] = false
	var cmp_path = base_path + object_path + act_obj_path + prefix_obj
	for i in range(num_objs):
		var tmp_path = cmp_path + str(i) + ".png"
		var size = _get_size_obj(tmp_path)
		var indexs = _get_indexs_single_obj(size)
		_add_single_obj(tmp_path, size, indexs[0], indexs[1])

func _get_indexs_single_obj(pieza):
	var blc_width = floor(pieza.x / 75)
	var blc_height = floor(pieza.y / 75)
	var x;
	var y;
	var no_encontrado = true
	while(no_encontrado):
		x = rng.randi_range(0, width - blc_width)
		y = rng.randi_range(0, height - blc_height)
		var ocupado = false
		for i in range(blc_width):
			for j in range(blc_height):
				ocupado = ocupado or objects[x+i][y+j]
		if !ocupado:
			no_encontrado = false
	for i in range(blc_width):
		for j in range(blc_height):
			objects[x+i][y+j] = true
	return [x, y]

func _get_size_obj(path):
	var obj = load(path)
	return obj.get_size()

func _add_single_obj(path, img_size, x, y):
	var spr_obj = Sprite.new()
	var tex_obj = load(path)
	var pos_x = _get_real_pos(x, block_size, img_size.x, offset_x)
	var pos_y = _get_real_pos(y, block_size, img_size.y, offset_y)
	var scr_obj = load(base_path + scr_path + "/objeto_enterrado.gd")
	spr_obj.set_texture(tex_obj)
	spr_obj.set_position(Vector2(pos_x, pos_y))
	spr_obj.set_script(scr_obj)
	spr_obj._set_init_data(img_size)
	spr_obj._set_shape()
	add_child(spr_obj)

func _check_final_state():
	if CavadoMaster.actual_objects == CavadoMaster.max_objects:
		CavadoMaster.game_state = 0
		yield(get_tree().create_timer(0.5), "timeout")
		emit_signal("win_game")
	elif CavadoMaster.act_life <= 0 and CavadoMaster.actual_energy <= 0:
		CavadoMaster.game_state = 0
		yield(get_tree().create_timer(0.5), "timeout")
		emit_signal("lose_game")

func  _restart_level():
	get_tree().reload_current_scene()
	
func _next_level():
	get_tree().change_scene(("res://juego_cavado/scenes/pantalla2_controles.tscn"))

func _on_ContinueButton_button_down():
	yield(get_tree().create_timer(0.5), "timeout")
	_next_level()

func _on_RetryButton_button_down():
	yield(get_tree().create_timer(0.5), "timeout")
	_restart_level()

func _on_TitleButton_button_down():
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().change_scene(("res://juego_cavado/scenes/niveles.tscn"))
