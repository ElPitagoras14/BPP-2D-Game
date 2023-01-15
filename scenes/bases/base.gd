extends Node2D


# Declare member variables here. Examples:
# var a = 2
onready var player=$Jugador

# Called when the node enters the scene tree for the first time.
func _ready():
	var baseStats=GameManager.getBaseStats()
	var lastZone=GameManager.getLastZone()
	if (lastZone["name"]==get_tree().current_scene.filename):
		player.position.x=lastZone["x"]
		player.position.y=lastZone["y"]
	if !baseStats["muebles"]:
		var muebles=get_node("muebles")
		remove_child(muebles)
		muebles.queue_free()
	else:
		var muebles=get_node("preMuebles")
		if muebles!=null:
			remove_child(muebles)
			muebles.queue_free()
	if !baseStats["decors"]:
		var decors=get_node("decors")
		if decors!=null:
			remove_child(decors)
			decors.queue_free()
	if !baseStats["wallDecors"]:
		var wallDecors=get_node("wallDecors")
		if wallDecors!=null:
			remove_child(wallDecors)
			wallDecors.queue_free()
	if !baseStats["utility"]:
		var utility=get_node("utility")
		if utility!=null:
			remove_child(utility)
			utility.queue_free()
	if !baseStats["trophy"]:
		var r=get_node("trophy-r")
		var c=get_node("trophy-c")
		var e=get_node("trophy-e")
		var a=get_node("trophy-a")
		if r!=null:
			remove_child(r)
			r.queue_free()
		if c!=null:
			remove_child(c)
			c.queue_free()
		if e!=null:
			remove_child(e)
			e.queue_free()
		if a!=null:
			remove_child(a)
			a.queue_free()
	else:
		if !baseStats["trophy-r"]:
			var r=get_node("trophy-r")
			remove_child(r)
		if !baseStats["trophy-c"]:
			var c=get_node("trophy-c")
			remove_child(c)
		if !baseStats["trophy-e"]:
			var e=get_node("trophy-e")
			remove_child(e)
		if !baseStats["trophy-a"]:
			var a=get_node("trophy-a")
			remove_child(a)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

