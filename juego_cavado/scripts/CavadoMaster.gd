extends Node

#Formato:
#[filas, columnas, capas, ubicación objeto, numero de partes]
var niveles = [
	[5, 5, 2, "/1/alas-", 2],
	[6, 5, 1, "/2/"],
	[6, 6, 1],
	[6, 6, 2],
	[6, 6, 2],
	[7, 6, 2],
	[8, 6, 2]
]

var nivel_actual = 0
var block_size = 75 #Debe ser el tamaño por cuadricula (incluye objetos)
var tool_act = "pico"
