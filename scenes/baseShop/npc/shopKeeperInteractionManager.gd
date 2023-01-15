extends InteractionManager

var inDialogue=false

func recieveInteraction()->void:
	if !inDialogue:
		inDialogue=true
		var newDialog = Dialogic.start('/shopBaseKeeperTalk')
		add_child(newDialog)
		newDialog.connect("timeline_end",self,'afterDialogue')

func afterDialogue(timelineName):
	print("Fin del dialogo")
	inDialogue=false
