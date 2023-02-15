extends Container
signal update_energy

var max_life = 5
var act_life = 5
var array_life = [0,0,0,0,0]

var size

var offset_x = 10
var offset_y = 30
var life_size_x = 60
var life_size_y = 35

var base_path = "res://juego_cavado"
var hud_path = "/assets/HUD"

# Called when the node enters the scene tree for the first time.
func _ready():
	_get_info()
	_fill_scene()
	pass # Replace with function body.

func _fill_scene():
	for i in range(max_life):
		var pos_x = _get_real_pos(i, life_size_x, life_size_x, offset_x)
		var pos_y = _get_real_pos(0, life_size_y, life_size_y, offset_y)
		var life = _get_new_life(pos_x, pos_y)
		array_life[i] = life
		self.add_child(life)
		

func _get_info():
	size = self.rect_size

func _get_new_life(pos_x, pos_y):
	var spr_life = Sprite.new()
	var name_tex_life = base_path + hud_path + "/heart.png"
	var tex_life = load(name_tex_life)
	spr_life.set_texture(tex_life)
	spr_life.set_position(Vector2(pos_x, pos_y))
	return spr_life
	
func _get_real_pos(index, blc_size, img_size, offset):
	return index * blc_size + img_size / 2 + offset
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _reduce_energy():
	if CavadoMaster.actual_energy > 0:
		return false
	var new_life_value = act_life - 1
	if new_life_value >= 0:
		_update_life(array_life[act_life - 1])
		act_life = new_life_value
		CavadoMaster.act_life = new_life_value
		var new_energy = int(CavadoMaster.max_energy * 0.2)
		CavadoMaster.actual_energy = new_energy
		emit_signal("update_energy")
		return false
	return true

func _update_life(life):
	var name_tex_no_life = base_path + hud_path + "/heart_border.png"
	var tex_no_life = load(name_tex_no_life)
	life.set_texture(tex_no_life)

func _on_ZonaCavar_reduce_energy():
	_reduce_energy()
