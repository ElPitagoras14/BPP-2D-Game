extends Sprite

var tex_size;
var g_pos;
var r_pos;
var layer;
var i;
var j;


# Called when the node enters the scene tree for the first time.
func _ready():
	tex_size = self.texture.get_size()
	g_pos = self.global_position
	r_pos = self.position
	pass # Replace with function body.
#
#func _input(event):
#	if event is InputEventMouseButton:
#		if event.button_mask == 0:
#			var click_pos = event.position
#			if _check_click(click_pos.x, click_pos.y):
#				_delete_block()
			
func _check_click(x, y):
	if abs(x - g_pos.x) < (tex_size.x / 2) and abs(y - g_pos.y) < (tex_size.y / 2):
		return true
	return false
	
func eliminar():
	queue_free()
	
# Función para obtener la posición en la matriz de 3 dimensiones del script de ZonaCavar
#func _get_indexs():
#	i = (r_pos.y / 75) - 0.5
#	j = (r_pos.x / 75) - 0.5
#	var res_path = self.texture.resource_path
#	var parts = res_path.split("/", false)
#	var text_name = parts[-1].split(".", false)
#	layer = int(text_name[0].split("-", false)[1])
#
#func _delete_block():
#	_get_indexs()
#	var act_value = volume[layer][i][j]
#	if !volume[layer+1][i][j] and !ZonaCavar.deleted:
#		get_parent().remove_child(self)
#		volume[layer][i][j] = false
#		ZonaCavar.deleted = true
#		ZonaCavar.act_layer = layer
#		return
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
