extends TileMap



func _ready():
	Signals.connect("on_game_over",self,"_on_game_over")

func _on_game_over():
	self.queue_free()
