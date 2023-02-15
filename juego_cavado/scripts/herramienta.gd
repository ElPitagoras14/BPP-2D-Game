extends Sprite

var tool_path = "res://juego_cavado/assets/misc/"
var animated

# Called when the node enters the scene tree for the first time.
func _ready():
	animated = get_parent().get_node("Animacion")
	pass # Replace with function body.


func _input(event):
	var offset = Vector2(30, -5)
	if (event is InputEventKey and event.scancode == KEY_ESCAPE):
		yield(get_tree().create_timer(0.5), "timeout")
		get_tree().change_scene(("res://juego_cavado/scenes/niveles.tscn"))
	if (event is InputEventMouseButton):
		animated.play(CavadoMaster.tool_act)
		hide()
	if !(event is InputEventMouseMotion):
		return
	var click_pos = event.position
	animated.set_position(click_pos)
	set_position(click_pos)

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

func _on_AnimatedSprite_animation_finished():
	show()
	animated.stop()
