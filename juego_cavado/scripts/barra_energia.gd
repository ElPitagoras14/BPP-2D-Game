extends TextureProgress

# Called when the node enters the scene tree for the first time.
func _ready():
	self.value = 100

func _update_progress():
	var max_energy = CavadoMaster.max_energy
	var act_energy = CavadoMaster.actual_energy
	var percent = float(act_energy) / max_energy
	self.value = percent * 100

func _on_ZonaCavar_reduce_energy():
	_update_progress()

func _on_Vida_update_energy():
	_update_progress()
