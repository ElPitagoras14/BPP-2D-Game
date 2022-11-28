extends Control


var total_niveles = CavadoMaster.niveles.size()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _change_to_play_scene():
	CavadoMaster.max_energy = _get_max_energy(CavadoMaster.nivel_actual)
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().change_scene("res://juego_cavado/scenes/zona_cavado.tscn")

func _get_max_energy(lvl):
	var info = CavadoMaster.niveles[lvl]
	var difficulty = float(100 - (lvl + 1) * 2) / 100
	difficulty = max(0.8, difficulty)
	var max_energy = info[0] * info[1] * (0.6 + (info[2] - 1) * 0.55) * difficulty
	return int(max_energy)

func _on_Nivel1_button_down():
	CavadoMaster.nivel_actual = 0
	_change_to_play_scene()

func _on_Nivel2_button_down():
	CavadoMaster.nivel_actual = 1
	_change_to_play_scene()

func _on_Nivel3_button_down():
	CavadoMaster.nivel_actual = 2
	_change_to_play_scene()
