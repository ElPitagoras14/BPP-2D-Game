extends TextureButton


export (String,FILE,"*.txt,*.json") var info
export (String,FILE,"*.png") var objeto


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func unlockObject():
	var texture=load(objeto)
	self.texture_normal=texture

func getInfoFile():
	return info

func getObjectPng():
	return objeto

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
