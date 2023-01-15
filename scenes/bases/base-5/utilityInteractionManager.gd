extends InteractionManager

export (String) var timeline
onready var player = $"../../Jugador"

func recieveInteraction()->void:
	var a=get_tree().current_scene.filename
	GameManager.saveLastZone(a,player.position.x,player.position.y)
	get_tree().change_scene("res://scenes/estanteria/estanteria.tscn")
