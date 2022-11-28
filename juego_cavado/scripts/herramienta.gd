extends Sprite

var tool_path = "res://juego_cavado/assets/misc/"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(event):
	var offset = Vector2(30, -5)
	if !(event is InputEventMouseMotion):
		return
	var click_pos = event.position
	set_position(click_pos + offset)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _set_tex_tool(name):
	var tex_tool = load(tool_path + name + ".png")
	set_texture(tex_tool)

func _on_Pico_button_down():
	_set_tex_tool("pico")
	CavadoMaster.tool_act = "pico"


func _on_Hacha_button_down():
	_set_tex_tool("hacha")
	CavadoMaster.tool_act = "hacha"


func _on_ZonaCavar_lose_game():
	hide()


func _on_ZonaCavar_win_game():
	hide()
