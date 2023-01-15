extends Sprite

var g_pos
var size
var follow = false
var completed = false
var tex_name

# Called when the node enters the scene tree for the first time.
func _ready():
	size = self.texture.get_size()
	_set_tex_name()
	g_pos = self.global_position
	pass # Replace with function body.

func _input(event):
	if !(event is InputEventMouse):
		return
	var click_pos = event.position
	if (event is InputEventMouseMotion):
		if completed:
			return
		if follow:
			set_global_position(click_pos)
	if !(event is InputEventMouseButton):
		return
	if event.button_mask != 0:
		return
	if !_check_click(click_pos.x, click_pos.y):
		return
	_add_fig_follow()
	
func _set_tex_name():
	var tmp = self.texture.get_path()
	var parte = tmp.split("/")[-1]
	tex_name = parte.split(".")[0]
	
func _add_fig_follow():
	var act_fig = CavadoMaster.actual_fig_name
		
	if !completed and !follow and act_fig == "":
		CavadoMaster.actual_fig_name = tex_name
		CavadoMaster.actual_fig = self
	elif follow and act_fig == tex_name:
		yield(get_tree().create_timer(0.1), "timeout")
		CavadoMaster.actual_fig_name = ""
		CavadoMaster.actual_fig = -1
	else:
		return
	follow = !follow
	
func _check_click(x, y):
	g_pos = self.global_position
	var range_x = abs(x - g_pos.x) < size.x / 2
	var range_y = abs(y - g_pos.y) < size.y / 2
	if range_x and range_y:
		return true
	return false
	
func _fit_position(g_pos):
	completed = true
	self.set_global_position(g_pos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
