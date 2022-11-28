extends Control

var lvl_actual = 0
var objetos = 4
var base_path = "res://juego_cavado"
var object_path = "/assets/objects"
var scr_path = "/scripts"
var spr_path = "/2/egip-"

# Called when the node enters the scene tree for the first time.
func _ready():
	_fill_scene()
	pass # Replace with function body.

func _fill_scene():
	var offset_figuras = CavadoMaster.offset_figuras[lvl_actual]
	var script = load(base_path + scr_path + "/sombra_construir.gd")
	for i in range(objetos):
		var pos = offset_figuras[i]
		var spr_figura = _get_new_sprite(pos.x, pos.y, i+1, script)
		add_child(spr_figura, true)
		
	
func _get_new_sprite(pos_x, pos_y, num, script):
	var spr_fig = Sprite.new()
	var name_spr_fig = base_path + object_path + spr_path + str(num) + ".png"
	var tex_fig = load(name_spr_fig)
	spr_fig.set_texture(tex_fig)
	spr_fig.set_position(Vector2(pos_x, pos_y))
	spr_fig.set_script(script)
	spr_fig._set_tex_values()
	return spr_fig
