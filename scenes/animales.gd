extends Node

onready var BGM = get_node("BGM")
var fileCong = File.new()
var data
onready var x=0

func _ready():
	BGM.play()


func _on_TextureButton_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	get_tree().change_scene("res://scenes/Controles.tscn")

func _on_JUGAR_pressed():
	get_node("Click").play()
	if(GameManager.player.animales.medallas==0 && GameManager.player.animales.pts==0 && GameManager.player.animales.mejorPuntaje==0 && x==0):
		x=1
		$Ayuda.popup()
	else:
		$Tema.popup()

func _on_salirmod_pressed():
	get_node("Click").play()
	$Tema.hide()

func _on_MAMIFEROS_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	leer()
	fileCong.store_string("MAMIFEROS,")
	fileCong.close()
	get_tree().change_scene("res://scenes/animales-juego.tscn")

func _on_AVES_pressed():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	leer()
	fileCong.store_string("AVES,")
	fileCong.close()
	get_tree().change_scene("res://scenes/animales-juego.tscn")

func leer():
	fileCong.open("res://data/juego_animales.dat", fileCong.WRITE)
	data = fileCong.get_csv_line()

func _on_Tema_about_to_show():
	$Tema/HBoxContainer/salirmod.disabled = false
	$Tema/HBoxContainer/VBoxContainer/HBoxContainer/MAMIFEROS.disabled = false
	$Tema/HBoxContainer/VBoxContainer/HBoxContainer2/AVES.disabled = false
	
func _on_TextureButton4_button_down():
	get_node("Click").play()
	yield(get_tree().create_timer(.3),"timeout")
	get_tree().change_scene("res://hubinicial/Hub/GameHub2D.tscn")


func _on_JUGAR_button_down():
	get_tree().change_scene("res://juego_cavado/scenes/niveles.tscn")


func _on_Cerrar_pressed():
	get_node("Click").play()
	$Ayuda.hide()


func _on_TextureButton_button_down():
	yield(get_tree().create_timer(.3),"timeout")
	get_tree().change_scene("res://juego_cavado/scenes/cavado_controles.tscn")
