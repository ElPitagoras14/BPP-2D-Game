extends TextureButton

class_name CardObj

var suit
var value
var face

func _ready():
	set_h_size_flags(3)
	set_v_size_flags(3)
	set_expand(true)
	set_stretch_mode(TextureButton.STRETCH_KEEP_ASPECT_CENTERED)
	self.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	
func _init(var s, var v):
	value = v
	suit = s
	face = load("res://assets/cards/"+str(suit)+""+str(value)+".png")
	set_normal_texture(face)

func _pressed():
	GameManager.chooseCard(self)
	
func cartaSeleccionada():
	print(value)