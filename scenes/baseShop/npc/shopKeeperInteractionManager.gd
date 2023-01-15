extends InteractionManager

var inDialogue=false
onready var popup=$"../../Popup"
var shopUiBtn = preload("../../shopUI/shopUI.tscn")

func recieveInteraction()->void:
	if !inDialogue:
		inDialogue=true
		var newDialog = Dialogic.start('/shopBaseKeeperTalk')
		add_child(newDialog)
		newDialog.connect("timeline_end",self,'afterDialogue')
		newDialog.connect("dialogic_signal", self, "dialog_listener")

func afterDialogue(timelineName):
	print("Fin del dialogo")
	inDialogue=false

func dialog_listener(timelineName):
	var shopPopup=shopUiBtn.instance()
	popup.add_child(shopPopup)
	popup.get_node("exit").raise()
	popup.show()
