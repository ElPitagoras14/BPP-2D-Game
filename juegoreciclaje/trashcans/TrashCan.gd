extends RigidBody2D

var picked = false

func _ready():
	Signals.connect("on_game_over", self, "_on_game_over")



func _physics_process(delta):
	self.rotation_degrees = 0
	if picked == true and get_node("../Player") != null:
		self.position = Vector2(get_node("../Player").position2D.global_position)
		
		
		
func _input(event):
	if Input.is_action_just_pressed("ui_pick") and get_node("../Player") != null:
		if picked == false:
			var bodies = $Area2D.get_overlapping_bodies()
			for body in bodies:
				if body.name == "Player" and get_node("../Player").canPick == true:
					picked = true
					get_node("../Player").canPick = false
		else:
			picked = false
			get_node("../Player").canPick = true
			if get_node("../Player")._animated_sprite.flip_h == false:
				apply_impulse(Vector2(), Vector2())
			else:
				apply_impulse(Vector2(), Vector2())
	
func _on_game_over():
	queue_free()
