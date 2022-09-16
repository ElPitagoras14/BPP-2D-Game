extends TextureButton

class_name CardObj

var suit
var value
var face
var back
var isBack

func _ready():
	set_h_size_flags(3)
	set_v_size_flags(3)
	set_expand(true)
	set_stretch_mode(TextureButton.STRETCH_KEEP_ASPECT_CENTERED)
	self.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	
func _init(var s, var v):
	value = v
	suit = s
	face = load("res://assets/cards/"+str(value)+"/"+str(suit)+".png")
	if face == null and suit == "flor":
		face = load("res://assets/cards/"+str(value)+"/fruto.png")
	back = load("res://assets/cards/card_back.png")
	set_normal_texture(face)

func _pressed():
	#
	if !isBack:
		GameManager.chooseCard(self)
	
func cartaSeleccionada():
	var newFace = load("res://assets/cards/"+str(value)+"/"+str(suit)+"Selected.png")
	if newFace == null:
		set_normal_texture(load("res://assets/cards/"+str(value)+"/frutoSelected.png"))
	else:
		set_normal_texture(newFace)

func backToNormal():
	set_normal_texture(face)

func flip():
	set_normal_texture(back)
	set_disabled(true)
	isBack = true
