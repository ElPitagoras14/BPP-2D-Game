extends Label


func _ready():
	pass

func _add_points(val):
	var new_point = CavadoMaster.points + val
	self.text = "Puntaje:\n" + str(new_point)
	CavadoMaster.points = new_point
	
func _point_event(val):
	_add_points(val)
