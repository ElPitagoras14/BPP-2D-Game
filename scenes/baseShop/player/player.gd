extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var MAX_SPEED=200
var velocity= Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	var input_vector=Vector2.ZERO
	input_vector.x=Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y=Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector=input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity=input_vector*MAX_SPEED
	else:
		velocity=Vector2.ZERO
		
	velocity=move_and_slide(velocity)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

