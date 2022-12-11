extends PopupDialog

export var dialoguePath="res://assets/baseShop/dialogueBox/shopKeeperDialogue.json"
export(float) var textSpeed=0.05

var dialog

var phraseNum=0
var finished=false

#func _ready():
#	$Timer.wait_time=textSpeed
#	dialog=getDialog()
#	assert(dialog,"dialog not found")
#	nextPhrase()

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") and visible==true:
		if finished:
			nextPhrase()
		elif phraseNum==0:
			$Timer.wait_time=textSpeed
			dialog=getDialog()
			assert(dialog,"dialog not found")
			nextPhrase()
		else:
			$dialogText.visible_characters=len($dialogText.text)

func getDialog()-> Array:
	var f=File.new()
	assert(f.file_exists(dialoguePath),"File path does not exist")
	
	f.open(dialoguePath,File.READ)
	var json=f.get_as_text()
	
	var output=parse_json(json)
	
	if typeof(output)== TYPE_ARRAY:
		return output
	else:
		return []
	
func nextPhrase()->void:
	if phraseNum>=len(dialog):
		visible=false
		phraseNum=0
		return
	
	finished=false
	
	$dialogText.bbcode_text=dialog[phraseNum]["Text"]
	
	$dialogText.visible_characters=0
	
	while $dialogText.visible_characters<len($dialogText.text):
		$dialogText.visible_characters+=1
		
		$Timer.start()
		yield($Timer,"timeout")
	
	finished=true
	phraseNum+=1
	return

