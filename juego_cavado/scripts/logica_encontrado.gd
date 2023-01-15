extends Label

var max_objects

# Called when the node enters the scene tree for the first time.
func _ready():
	max_objects = CavadoMaster.max_objects
	self.text = "Objetos:\n0/" + str(max_objects)

func _add_object():
	var new_obj = CavadoMaster.actual_objects + 1
	self.text = "Objetos:\n" + str(new_obj) + "/" + str(max_objects)
	CavadoMaster.actual_objects = new_obj
	
func _found_object():
	_add_object()
