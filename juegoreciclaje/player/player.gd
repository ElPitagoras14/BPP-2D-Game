extends KinematicBody2D

const WALK_FORCE = 600
const WALK_MAX_SPEED = 260
const STOP_FORCE = 1300
const JUMP_SPEED = 350

var canPick = true

var Points: int = 0
export var life: int = 5
var velocity = Vector2()

onready var gravity = 400
onready var _animated_sprite = $sprite
onready var position2D = $Position2D
onready var collected = $collected
onready var miss = $miss


func _ready():
	Signals.connect("on_game_over", self, "_on_game_over")
	loadSprite()
	
func _physics_process(delta):
	# Horizontal movement code. First, get the player's input.
	
	var walk = WALK_FORCE * (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	if walk == 600:
		_animated_sprite.play("run")
		_animated_sprite.set_flip_h( false )
	elif walk == -600:
		_animated_sprite.play("run")
		_animated_sprite.set_flip_h( true )
		
	# Slow down the player if they're not trying to move.
	if abs(walk) < WALK_FORCE * 0.2:
		# The velocity, slowed down a bit, and then reassigned.
		velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
		_animated_sprite.stop()
	else:
		velocity.x += walk * delta
	# Clamp to the maximum horizontal movement speed.
	velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)

	# Vertical movement code. Apply gravity.
	velocity.y += gravity * delta
	
	# Move based on the velocity and snap to the ground.
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
	# Check for jumping. is_on_floor() must be called after movement code.
	if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		velocity.y = -JUMP_SPEED
		_animated_sprite.play("jump")


func damage():
	miss.play()
	Signals.emit_signal("on_player_life_changed", life)
	life -= 1
	if life <=0:
		Signals.emit_signal("on_game_over")
	

func addPoints(amount: int):
	collected.play()
	Points += amount
	
func _on_game_over():
	queue_free()
	
func loadSprite():
	if GameManager.player!=null:
		if GameManager.player.sprite == 1:
			_animated_sprite.frames.set_frame("run", 0, load("res://assets/Sprites/Ben/ben-a.svg"))
			_animated_sprite.frames.set_frame("run", 1, load("res://assets/Sprites/Ben/ben-b.svg"))
			_animated_sprite.frames.set_frame("jump", 0, load("res://assets/Sprites/Ben/ben-a.svg"))
			_animated_sprite.frames.set_frame("jump", 1, load("res://assets/Sprites/Ben/ben-c.svg"))
			_animated_sprite.frames.set_frame("jump", 2, load("res://assets/Sprites/Ben/ben-d.svg"))
		elif GameManager.player.sprite == 2:
			_animated_sprite.frames.set_frame("run", 0, load("res://assets/Sprites/Ben2/ben2-a.svg"))
			_animated_sprite.frames.set_frame("run", 1, load("res://assets/Sprites/Ben2/ben2-b.svg"))
			_animated_sprite.frames.set_frame("jump", 0, load("res://assets/Sprites/Ben2/ben2-a.svg"))
			_animated_sprite.frames.set_frame("jump", 1, load("res://assets/Sprites/Ben2/ben2-c.svg"))
			_animated_sprite.frames.set_frame("jump", 2, load("res://assets/Sprites/Ben2/ben2-d.svg"))
		elif GameManager.player.sprite == 3:
			_animated_sprite.frames.set_frame("run", 0, load("res://assets/Sprites/Jordyn/jordyn-a.svg"))
			_animated_sprite.frames.set_frame("run", 1, load("res://assets/Sprites/Jordyn/jordyn-b.svg"))
			_animated_sprite.frames.set_frame("jump", 0, load("res://assets/Sprites/Jordyn/jordyn-a.svg"))
			_animated_sprite.frames.set_frame("jump", 1, load("res://assets/Sprites/Jordyn/jordyn-c.svg"))
			_animated_sprite.frames.set_frame("jump", 2, load("res://assets/Sprites/Jordyn/jordyn-d.svg"))
		elif GameManager.player.sprite == 4:
			_animated_sprite.frames.set_frame("run", 0, load("res://assets/Sprites/Jordyn2/jordyn2-a.svg"))
			_animated_sprite.frames.set_frame("run", 1, load("res://assets/Sprites/Jordyn2/jordyn2-b.svg"))
			_animated_sprite.frames.set_frame("jump", 0, load("res://assets/Sprites/Jordyn2/jordyn2-a.svg"))
			_animated_sprite.frames.set_frame("jump", 1, load("res://assets/Sprites/Jordyn2/jordyn2-c.svg"))
			_animated_sprite.frames.set_frame("jump", 2, load("res://assets/Sprites/Jordyn2/jordyn2-d.svg"))
	else:
		_animated_sprite.frames.set_frame("run", 0, load("res://assets/Sprites/Ben/ben-a.svg"))
		_animated_sprite.frames.set_frame("run", 1, load("res://assets/Sprites/Ben/ben-b.svg"))
		_animated_sprite.frames.set_frame("jump", 0, load("res://assets/Sprites/Ben/ben-a.svg"))
		_animated_sprite.frames.set_frame("jump", 1, load("res://assets/Sprites/Ben/ben-c.svg"))
		_animated_sprite.frames.set_frame("jump", 2, load("res://assets/Sprites/Ben/ben-d.svg"))
