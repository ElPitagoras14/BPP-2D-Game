extends Node

onready var TrashCanContainer = $TrashCanContainer
onready var trashContainer = $TrashContainer
onready var ayuda = $Ayuda
var preBlackTrashCan = preload("res://juegoreciclaje/trashcans/BlackTrashCan.tscn")
var preYellowTrashCan = preload ("res://juegoreciclaje/trashcans/YellowTrashCan.tscn")

var is_paused = false setget set_is_paused

func _ready():
	Signals.connect("on_blacktrash_spawn", self, "_on_blacktrash_spawn")
	Signals.connect("on_yellowtrash_spawn", self, "_on_yellowtrash_spawn")
	Signals.connect("ayudaPressed", self, "ayudaPressed")

func _on_blacktrash_spawn():
	var blackT = preBlackTrashCan.instance()
	blackT.position = Vector2(-118,44)
	blackT.set_collision_layer_bit(0, false)
	blackT.set_collision_mask_bit(0, false)
	blackT.set_collision_layer_bit(5, true)
	blackT.set_collision_mask_bit(5, true)
	self.add_child_below_node(TrashCanContainer,blackT)
	
func _on_yellowtrash_spawn():
	var yellowT = preYellowTrashCan.instance()
	yellowT.position = Vector2(665,44)
	yellowT.set_collision_layer_bit(0, false)
	yellowT.set_collision_mask_bit(0, false)
	yellowT.set_collision_layer_bit(4, true)
	yellowT.set_collision_mask_bit(4, true)
	self.add_child_below_node(TrashCanContainer, yellowT)

func ayudaPressed():
	self.is_paused = !is_paused

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	ayuda.visible = is_paused
	print(ayuda.visible)
	


func _on_Unpause_pressed():
	self.is_paused = false
