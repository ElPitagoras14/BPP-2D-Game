extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

const GRAVITY = 600
const WALK_SPEED = 200
var velocity = Vector2()
const JUMP_FORCE = 350
var screen_size
onready var _animated_sprite = $AnimatedSprite

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	
	if Input.is_action_pressed("ui_left"):
		if is_on_floor():
			_animated_sprite.play("run")
		get_node( "AnimatedSprite" ).set_flip_h( true )
		velocity.x = -WALK_SPEED
	elif Input.is_action_pressed("ui_right"):
		if is_on_floor():
			_animated_sprite.play("run")
		get_node( "AnimatedSprite" ).set_flip_h( false )
		velocity.x = WALK_SPEED
	elif Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y = -JUMP_FORCE
	elif !is_on_floor():
		_animated_sprite.play("jump")
	else:
		# velocity.x = 0
		# smoothen the stop
		velocity.x = lerp(velocity.x, 0, 0.1)
		_animated_sprite.stop()
	 
	velocity = move_and_slide(velocity, Vector2.UP)
