extends Node

#Formato:
#[filas, columnas, capas, ubicación objeto, numero de partes]
var niveles = [
	[5, 5, 1, "/1", 4],
	[6, 5, 1, "/2", 4],
	[6, 6, 1, "/3", 4],
	[6, 6, 2, "/4", 4],
	[6, 6, 2, "/5", 4],
	[7, 6, 2, "/6", 4],
	[8, 6, 2, "/7", 4]
]

var shadow_colors = [
	Color(0.9450, 0.6862, 0.6862),
	Color(0.3490, 0.8509, 0.5843),
	Color(0.5843, 0.6352, 0.8117),
	Color(0.8705, 0.7568, 0.4862)
]

var unlocked_levels;

var offset_figuras = [
	[Vector2(271,134), Vector2(377,160), Vector2(437,326), Vector2(291,331)],
	[Vector2(271,134), Vector2(377,160), Vector2(437,326), Vector2(291,331)],
	[Vector2(271,134), Vector2(377,160), Vector2(437,326), Vector2(291,331)],
	[Vector2(271,134), Vector2(377,160), Vector2(437,326), Vector2(291,331)],
	[Vector2(271,134), Vector2(377,160), Vector2(437,326), Vector2(291,331)],
	[Vector2(271,134), Vector2(377,160), Vector2(437,326), Vector2(291,331)],
	[Vector2(271,134), Vector2(377,160), Vector2(437,326), Vector2(291,331)],
]

var nivel_actual = 0
var block_size = 75 #Debe ser el tamaño por cuadricula (incluye objetos)
var tool_act = "hacha"

var act_life = 5
var max_energy
var actual_energy

var points = 0

var max_objects = 4
var actual_objects

# 0 = No jugable
# 1 = Jugable
var game_state = 0

# Zona construir
var actual_fig
var actual_fig_name = ""
