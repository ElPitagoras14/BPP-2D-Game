extends Control

var base_path = "res://juego_cavado"
var scrp_path = "/scripts"
var icon_path = "/assets/niveles_iconos"
var icon_prefix = "/nivel-"
var total_niveles = CavadoMaster.niveles.size()
var offset_x = 30
var offset_y = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	CavadoMaster.unlocked_levels = GameManager.getUnlockedLvl()
	get_parent().get_node("AudioStreamPlayer").play()
	_fill_scene()
	pass # Replace with function body.

func _fill_scene():
	for tex_num in range(total_niveles):
		var spr_block = Sprite.new()
		var name_tex_block = base_path + icon_path + icon_prefix + str(tex_num + 1) + ".png"
		var script = load(base_path + scrp_path + "/nivel.gd")
		var tex_block = load(name_tex_block)
		var pos_x = offset_x + tex_num * 158
		var pos_y = offset_y
		if tex_num >= 5:
			pos_y += 158
			pos_x = offset_x + (tex_num - 5) * 158
		spr_block.set_texture(tex_block)
		spr_block.set_position(Vector2(pos_x, pos_y))
		spr_block.set_script(script)
		spr_block._set_nivel(tex_num)
		self.add_child(spr_block)



func _on_TextureButton4_button_down():
	yield(get_tree().create_timer(.3),"timeout")
	get_tree().change_scene("res://juego_cavado/scenes/menu_cavado.tscn")
