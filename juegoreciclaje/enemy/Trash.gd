extends Area2D
class_name Trash
export var VerticalSpeed := 10.0
export var pointsGiven := 0
export var trashColor := ""

func _ready():
	Signals.connect("on_game_over", self, "_on_game_over")

func _physics_process(delta):
	position.y += VerticalSpeed * delta
	if position.y >= 512:
		if get_node("../Player") != null:
			get_node("../Player").damage()
		Signals.emit_signal("on_combo_break")
		queue_free()
	
		
		



func _on_Trash_area_entered(area):
	if area.get_parent().is_in_group(trashColor):
		get_node("../Player").addPoints(pointsGiven)
		Signals.emit_signal("on_score_increment",pointsGiven)
		Signals.emit_signal("on_combo_increment")
		queue_free()

func _on_game_over():
	queue_free()
