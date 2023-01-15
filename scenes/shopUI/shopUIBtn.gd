extends TextureButton


export (String) var itemName
export (String) var price
export (String) var id
export (bool) var purcharsed

onready var itemNameLabel=$ItemName
onready var priceLabel=$Price

# Called when the node enters the scene tree for the first time.
func _ready():
	if purcharsed:
		itemNameLabel.text=itemName+"(COMPRADO)"
		itemNameLabel.add_color_override("font_color",Color("ff2200"))
		itemNameLabel.add_color_override("font_color_shadow",Color("ffffff"))
	else:
		itemNameLabel.text=itemName
	priceLabel.text="x"+price

func getItemName():
	return itemName

func getPrice():
	return price

func purchase():
	purcharsed=true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
