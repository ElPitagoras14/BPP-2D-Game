extends Node

onready var TrashCanContainer = $TrashCanContainer
var preBlackTrashCan = preload("res://juegoreciclaje/trashcans/BlackTrashCan.tscn")
var preYellowTrashCan = preload ("res://juegoreciclaje/trashcans/YellowTrashCan.tscn")

func _ready():
	Signals.connect("on_blacktrash_spawn", self, "_on_blacktrash_spawn")
	Signals.connect("on_yellowtrash_spawn", self, "_on_yellowtrash_spawn")

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
	yellowT.position = Vector2(655,44)
	yellowT.set_collision_layer_bit(0, false)
	yellowT.set_collision_mask_bit(0, false)
	yellowT.set_collision_layer_bit(4, true)
	yellowT.set_collision_mask_bit(4, true)
	self.add_child_below_node(TrashCanContainer, yellowT)
