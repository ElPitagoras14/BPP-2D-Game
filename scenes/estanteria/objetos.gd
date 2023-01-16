extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var unlockSprites=[]

# Called when the node enters the scene tree for the first time.
func _ready():
	if GameManager.currentPlayer==null:
		GameManager.currentPlayer="Hola"
	var objetos=GameManager.getObjects()
	for i in range(len(objetos)):
		var button=get_node("objetos/"+str(i))
		if objetos[i]:
			button.connect('pressed', self, '_pressed', [button])
			button.unlockObject()

func _pressed(button):
	if button.getInfoFile()!="" and button.getObjectPng()!="":
		var text=loadFile(button.getInfoFile())
		var objeto=button.getObjectPng()
		objeto=load(objeto)
		var name=text[0]
		var info=text[1]
		$Popup/info.text=info
		$Popup/name.text=name
		$Popup/objeto.texture=objeto
		$Popup.show()

func loadFile(file):
	var res=[]
	var f = File.new()
	f.open(file, File.READ)
	res.append(f.get_line())
	var line=""
	while not f.eof_reached(): # iterate through all lines until the end of file is reached
		line+= f.get_line()
		line+="\n"
	f.close()
	res.append(line)
	return res
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_exit_pressed():
	$Popup.hide()


func _on_sceneExit_pressed():
	var lastZone=GameManager.getLastZone()
	get_tree().change_scene(lastZone["name"])
