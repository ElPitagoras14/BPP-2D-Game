extends Control

var lvl_actual
var objetos = 4
var base_path = "res://juego_cavado"
var object_path = "/assets/objects"
var scr_path = "/scripts"
var spr_path = "/2/egip-"

var size
var offset_x
var pos_y = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	size = self.rect_size
	offset_x = size.x / 2
	lvl_actual = CavadoMaster.nivel_actual
	var info = CavadoMaster.niveles[lvl_actual]
	objetos = info[4]
	_fill_scene()
	pass # Replace with function body.
	
func _fill_scene():
	var offset_figuras = CavadoMaster.offset_figuras[lvl_actual]
	var script = load(base_path + scr_path + "/objeto_construir.gd")
	for i in range(objetos):
		var spr_figura = _get_new_sprite(offset_x, i, i+1, script)
		add_child(spr_figura, true)

func _get_new_sprite(pos_x, i, num, script):
	var spr_fig = Sprite.new()
	var name_spr_fig = base_path + object_path + spr_path + str(num) + ".png"
	var tex_fig = load(name_spr_fig)
	var size = tex_fig.get_size()
	pos_y += size.y / 2
	spr_fig.set_texture(tex_fig)
	spr_fig.set_position(Vector2(pos_x, pos_y))
	pos_y += size.y / 2
	spr_fig.set_script(script)
	spr_fig._set_tex_name()
	return spr_fig


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
