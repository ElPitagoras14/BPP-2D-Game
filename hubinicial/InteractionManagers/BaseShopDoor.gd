extends InteractionManager

export (String,FILE,"*.tscn,*.scn") var targetScene

onready var player = $"../../Jugador"

func recieveInteraction()->void:
	if !targetScene:
		print("No hay escena puesta")
		return
	else:
		GameManager.saveCurrentPlayerPosition( player.position.x - 10 , player.position.y)
		var err=get_tree().change_scene(targetScene)
		
		if err!=OK:
			print(err)
		
		return


