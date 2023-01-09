extends Sprite
signal win_game

var size
var tex_name

# Called when the node enters the scene tree for the first time.
func _ready():
	var popup = get_parent().get_parent().get_node("Win")
	self.connect("win_game", popup, "_show")
	var zona_construir = get_parent()
	self.connect("win_game", zona_construir, "_win_game")
	pass

func _input(event):
	if !(event is InputEventMouseButton):
		return
	if event.button_mask != 0:
		return
	var click_pos = event.position
	if !_check_click(click_pos.x, click_pos.y):
		return
	if CavadoMaster.actual_fig_name == "":
		return
	var idx_master = CavadoMaster.actual_fig_name.split("-")[-1]
	var idx_local = tex_name.split("-")[-1]
	if idx_master == idx_local:
		CavadoMaster.actual_objects += 1
		CavadoMaster.actual_fig._fit_position(self.global_position)
		if CavadoMaster.actual_objects == CavadoMaster.max_objects:
			yield(get_tree().create_timer(0.3), "timeout")
			emit_signal("win_game")

func _set_helper_color(num):
	var color = CavadoMaster.shadow_colors[num]
	set_self_modulate(color)

func _set_tex_values():
	size = self.texture.get_size()
	var tmp = self.texture.get_path()
	var parte = tmp.split("/")[-1]
	tex_name = parte.split(".")[0]

func _check_click(x, y):
	var g_pos = self.global_position
	var range_x = abs(x - g_pos.x) < 15
	var range_y = abs(y - g_pos.y) < 15
	if range_x and range_y:
		return true
	return false
