extends KinematicBody2D

export var WALK_SPEED: float = 100
export var RUN_MULTIPLIER: float = 1.5
var velocity: Vector2 = Vector2(0,0)
var multiplier: float = 1.0
export var starting_position: Vector2 = Vector2(0,1)

onready var animation_tree = $AnimationTree
onready var state_machine =  animation_tree.get("parameters/playback")
onready var interactionManager: InteractionManager = $InteractionManager

func _ready():
	state_machine.start("Start")
	update_animation_parameters(starting_position)

func _physics_process(_delta):
	
	if(Input.is_action_pressed("ui_run")):
		multiplier = 1.5
	else:
		multiplier = 1.0
	
	velocity = Input.get_vector("ui_left","ui_right","ui_up","ui_down") * WALK_SPEED * multiplier	
	
	update_animation_parameters(velocity)
	pick_new_state()

	move_and_slide(velocity)
	
	#interaction
	if(Input.is_action_just_pressed("ui_select")):
		interactionManager.startInteraction()

func update_animation_parameters(move_input:Vector2):
	
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/idle/blend_position",move_input)
		animation_tree.set("parameters/walk/blend_position",move_input)
		animation_tree.set("parameters/run/blend_position",move_input)
		
func pick_new_state():
	if(velocity != Vector2.ZERO):
		if(Input.is_action_pressed("ui_run")):
			state_machine.travel("run")
		else:
			state_machine.travel("walk")
	else:
		state_machine.travel("idle")
		
