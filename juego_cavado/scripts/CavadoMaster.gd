extends Node

#Formato:
#[filas, columnas, capas, ubicación objeto, numero de partes]
var niveles = [
	[5, 5, 1, "/1/alas-", 2],
	[6, 5, 1, "/1/alas-", 2],
	[6, 6, 1, "/1/alas-", 2],
	[6, 6, 2, "/1/alas-", 2],
	[6, 6, 2, "/1/alas-", 2],
	[7, 6, 2, "/1/alas-", 2],
	[8, 6, 2, "/1/alas-", 2]
]

var offset_figuras = [
	[Vector2(304,157), Vector2(399,176), Vector2(468,340), Vector2(305,353)]
]

var nivel_actual = 0
var block_size = 75 #Debe ser el tamaño por cuadricula (incluye objetos)
var tool_act = "pico"

var act_life = 3
var max_energy
var actual_energy

var points = 0

var max_objects = 2
var actual_objects

# 0 = No jugable
# 1 = Jugable
var game_state = 0

# Zona construir
var actual_fig
var actual_fig_name = ""
