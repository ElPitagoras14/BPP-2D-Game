extends Control

var is_paused = false setget set_is_paused
func _ready():
	Signals.connect("pausePressed", self, "_pausePressed")
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_pause"):
		Signals.emit_signal("pausePressed")
		

func _pausePressed():
	self.is_paused = !is_paused
	get_node("Click").play()

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused
	
func _on_ResumeButton_pressed():
	self.is_paused = false
	get_node("Click").play()


func _on_QuitGame_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.4),"timeout")
	self.is_paused = false
	
	Signals.emit_signal("on_game_over")
	
