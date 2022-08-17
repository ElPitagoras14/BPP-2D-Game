extends KinematicBody2D

const WALK_FORCE = 600
const WALK_MAX_SPEED = 200
const STOP_FORCE = 1300
const JUMP_SPEED = 350

var canPick = true

var Points: int = 0
export var life: int = 6
var velocity = Vector2()

onready var gravity = 500
onready var sprite = $Sprite
onready var position2D = $Position2D


func _ready():
	Signals.connect("on_game_over", self, "_on_game_over")
	
func _physics_process(delta):
	# Horizontal movement code. First, get the player's input.
	var walk = WALK_FORCE * (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	# Slow down the player if they're not trying to move.
	if abs(walk) < WALK_FORCE * 0.2:
		# The velocity, slowed down a bit, and then reassigned.
		velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
	else:
		velocity.x += walk * delta
	# Clamp to the maximum horizontal movement speed.
	velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)

	# Vertical movement code. Apply gravity.
	velocity.y += gravity * delta

	# Move based on the velocity and snap to the ground.
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
	print(position.x)
	# Check for jumping. is_on_floor() must be called after movement code.
	if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		velocity.y = -JUMP_SPEED

func damage():
	life -= 1
	Signals.emit_signal("on_player_life_changed", life)
	if life <=0:
		Signals.emit_signal("on_game_over")
	

func addPoints(amount: int):

	Points += amount
	
func _on_game_over():
	queue_free()
