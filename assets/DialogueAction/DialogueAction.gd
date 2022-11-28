extends Popup

export(String, FILE, "*.json") var dFile

var dialogue=[]
var currentDialogueId=0
var dActive=false

func loadDialogue():
	var file=File.new()
	if file.file_exists(dFile):
		file.open(dFile,File.READ)
		return parse_json(file.get_as_text())

func nextScript():
	currentDialogueId+=1
	
	if currentDialogueId>=len(dialogue):
		$Timer.start()
		$NinePatchRect.visible=false;
		return
	
	$NinePatchRect/Text.text=dialogue[currentDialogueId]["text"]

func _input(event):
	
	if not dActive:
		return
	
	if event.is_action_pressed("ui_select"):
		nextScript()

func start():
	
	if dActive:
		return
	
	popup()
	dActive=true
	$NinePatchRect.visible=true
	dialogue=loadDialogue()
	currentDialogueId=-1
	nextScript()

# Called when the node enters the scene tree for the first time.
func _ready():
	$NinePatchRect.visible=false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Timer_timeout():
	dActive=false
