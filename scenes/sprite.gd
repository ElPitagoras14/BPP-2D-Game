extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var speed = 150
const JUMP_FORCE = 500
var screen_size
onready var _animated_sprite = $AnimatedSprite

func _ready():
	screen_size = get_viewport_rect().size

func _process(_delta):
	if Input.is_action_pressed("ui_right"):
		_animated_sprite.play("run")
		get_node( "AnimatedSprite" ).set_flip_h( false )
		position.x += speed * _delta
	elif Input.is_action_pressed("ui_left"):
		_animated_sprite.play("run")
		get_node( "AnimatedSprite" ).set_flip_h( true )
		position.x -= speed * _delta
	else:
		_animated_sprite.stop()
	
	 #if Input.is_action_pressed("ui_up") and is_on_floor():
		#velocity.y = -JUMP_FORCE
	
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
