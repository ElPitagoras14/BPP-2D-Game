extends Node2D

onready var spawnTimer := $SpawnTimer

var preloadedTrash := [
	preload("res://juegoreciclaje/enemy/RedTrash.tscn"),
	preload("res://juegoreciclaje/enemy/BlueTrash.tscn"),
	preload("res://juegoreciclaje/enemy/GreenTrash.tscn"),
	preload("res://juegoreciclaje/enemy/YellowTrash.tscn"),
	preload("res://juegoreciclaje/enemy/BlackTrash.tscn")
	]

var nextSpawnTime := 4.5
var sizeRemover: int = 2
var lastTrash: int = 9
var currentTrash: int = 9





func _ready():
	Signals.connect("on_game_over", self, "_on_game_over")
	Signals.connect("on_blacktrash_spawn", self, "_on_blacktrash_spawn")
	Signals.connect("on_yellowtrash_spawn", self, "_on_yellowtrash_spawn")
	randomize()
	spawnTimer.start(nextSpawnTime)

	
func _on_blacktrash_spawn():
	sizeRemover -=1
	
	
func _on_yellowtrash_spawn():
	sizeRemover -=1


func _on_SpawnTimer_timeout():
	#Spawn the enemy
	var ViewRect := get_viewport_rect()
	var xPos := rand_range(-183, 689 )
	
	while currentTrash == lastTrash:
		currentTrash = randi() % (preloadedTrash.size() - sizeRemover)
		
	var trashPreload = preloadedTrash[currentTrash]
	lastTrash = currentTrash
	var trash: Trash = trashPreload.instance()
	trash.position = Vector2(xPos, position.y)
	get_tree().current_scene.add_child_below_node(self, trash)
	
	
	#Restart the timer
	spawnTimer.start(nextSpawnTime)
func _on_game_over():
	queue_free()
