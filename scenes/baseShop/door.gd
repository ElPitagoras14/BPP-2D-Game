extends InteractionManager

export (String,FILE,"*.tscn,*.scn") var targetScene

func recieveInteraction()->void:
	if !targetScene:
		print("No hay escena puesta")
		return
	else:
		var err=get_tree().change_scene(targetScene)
		
		if err!=OK:
			print(err)
		
		return
