extends InteractionManager

var inDialogue=false

func recieveInteraction()->void:
	if !inDialogue:
		inDialogue=true
		var newDialog = Dialogic.start('/animalsNpcTimeline')
		add_child(newDialog)
		newDialog.connect("timeline_end",self,'afterDialogue')

func afterDialogue(timelineName):
	inDialogue=false

