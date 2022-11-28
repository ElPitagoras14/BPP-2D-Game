extends Sprite

var size
var tex_name

# Called when the node enters the scene tree for the first time.
func _ready():
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
		print("Conseguido")
		
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
