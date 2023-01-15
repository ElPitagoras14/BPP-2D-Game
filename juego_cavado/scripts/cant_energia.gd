extends Label

var max_energy = CavadoMaster.max_energy
# Called when the node enters the scene tree for the first time.

func _ready():
	self.set_visible(false)
	_update_text()
	pass # Replace with function body.

func _update_text():
	var act_energy = CavadoMaster.actual_energy
	self.text = str(act_energy) + " / " + str(max_energy)

func _on_BarraEnergia_mouse_entered():
	self.set_visible(true)


func _on_BarraEnergia_mouse_exited():
	self.set_visible(false)


func _on_ZonaCavar_reduce_energy():
	_update_text()


func _on_Vida_update_energy():
	_update_text()
