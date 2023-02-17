extends Control

var lvl_actual
var base_path = "res://juego_cavado"
var object_path = "/assets/objects"
var scr_path = "/scripts"
var prefix_shadow = "/shadow-"
var act_obj_path
var num_objs

var shadows = []

# Called when the node enters the scene tree for the first time.
func _ready():
	CavadoMaster.actual_objects = 0
	CavadoMaster.points = 0
	lvl_actual = CavadoMaster.nivel_actual
	_get_info()
	_fill_scene()
	_show_helper()
	get_parent().get_node("AudioStreamPlayer").play()
	pass # Replace with function body.
	
func _get_info():
	var info = CavadoMaster.niveles[lvl_actual]
	act_obj_path = info[3]
	num_objs = info[4]

func _fill_scene():
	var offset_figuras = CavadoMaster.offset_figuras[lvl_actual]
	var script = load(base_path + scr_path + "/sombra_construir.gd")
	shadows.resize(num_objs)
	for i in range(num_objs):
		var pos = offset_figuras[i]
		var spr_figura = _get_new_sprite(pos.x, pos.y, i, script)
		add_child(spr_figura, true)
		shadows[i] = spr_figura

func _show_helper():
	yield(get_tree().create_timer(5), "timeout")
	for i in range(num_objs):
		var spr_fig = shadows[i]
		spr_fig._set_helper_color(i)
	
func _get_new_sprite(pos_x, pos_y, num, script):
	var spr_fig = Sprite.new()
	var name_spr_fig = base_path + object_path + act_obj_path + prefix_shadow + str(num) + ".png"
	var tex_fig = load(name_spr_fig)
	spr_fig.set_texture(tex_fig)
	spr_fig.set_position(Vector2(pos_x, pos_y))
	spr_fig.set_script(script)
	spr_fig._set_tex_values()
	return spr_fig
	
func _win_game():
	GameManager.saveUnlockedLvl(CavadoMaster.nivel_actual + 1)
	var nivel_actual = CavadoMaster.nivel_actual
	CavadoMaster.unlocked_levels[nivel_actual + 1] = true
	pass
	
func _input(event):
	if (event is InputEventKey and event.scancode == KEY_ESCAPE):
		yield(get_tree().create_timer(0.5), "timeout")
		get_tree().change_scene(("res://juego_cavado/scenes/niveles.tscn"))

func _change_to_level(i):
	if CavadoMaster.unlocked_levels[i]:
		CavadoMaster.nivel_actual = i
		_change_to_play_scene()

func _change_to_play_scene():
	CavadoMaster.max_energy = _get_max_energy(CavadoMaster.nivel_actual)
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().change_scene("res://juego_cavado/scenes/zona_cavado.tscn")
	
func _get_max_energy(lvl):
	var info = CavadoMaster.niveles[lvl]
	var difficulty = float(100 - (lvl + 1) * 2) / 100
	difficulty = max(0.8, difficulty)
	var max_energy = info[0] * info[1] * (0.75 + (info[2] - 1) * 0.55) * difficulty
	return int(max_energy)

func _on_TitleButton_button_down():
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().change_scene(("res://juego_cavado/scenes/niveles.tscn"))


func _on_ContinueButton_button_down():
	yield(get_tree().create_timer(0.5), "timeout")
	_change_to_level(CavadoMaster.nivel_actual + 1)
