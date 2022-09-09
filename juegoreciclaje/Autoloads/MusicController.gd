extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	pass # Replace with function body.


func play_music():
	$Music.play()
func stop_music():
	$Music.stop()
