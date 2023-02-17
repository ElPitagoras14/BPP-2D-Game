extends Sprite

var nivel
var g_pos
var block_size = 118


# Called when the node enters the scene tree for the first time.
func _ready():
	g_pos = self.global_position
	pass # Replace with function body.

func _set_nivel(nivel):
	self.nivel = nivel
	if !CavadoMaster.unlocked_levels[str(nivel)]:
		set_self_modulate(Color(0.4352, 0.3686, 0.3686))

func _change_to_level(i):
	if CavadoMaster.unlocked_levels[str(i)]:
		CavadoMaster.nivel_actual = i
		_change_to_play_scene()

func _change_to_play_scene():
	CavadoMaster.max_energy = _get_max_energy(CavadoMaster.nivel_actual)
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().change_scene("res://juego_cavado/scenes/pantalla1_controles.tscn")
	
func _get_max_energy(lvl):
	var info = CavadoMaster.niveles[lvl]
	var difficulty = float(100 - (lvl + 1) * 2) / 100
	difficulty = max(0.8, difficulty)
	var max_energy = info[0] * info[1] * (0.55 + (info[2] - 1) * 0.50) * difficulty
	return int(max_energy)
	
func _input(event):
	if !(event is InputEventMouseButton):
		return
	var click_pos = event.position
	if _check_click(click_pos.x, click_pos.y):
		_change_to_level(nivel)
	
func _check_click(x, y):
	var range_x = abs(x - g_pos.x) < block_size / 2
	var range_y = abs(y - g_pos.y) < block_size / 2
	if range_x and range_y:
		return true
	return false
