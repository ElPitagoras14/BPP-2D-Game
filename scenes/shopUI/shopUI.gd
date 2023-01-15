extends Control


export (String,FILE,"*.json") var itemListJson
var shopUiBtn = preload("shopUIBtn.tscn")
onready var itemList=$TextureRect/ScrollContainer/itemList
onready var moneyLabel=$moneyRect/money
onready var popup=$TextureRect/Popup
var list
var baseStats
var upgrade
var allPurchased=true
# Called when the node enters the scene tree for the first time.
func _ready():
	if GameManager.currentPlayer==null:
		GameManager.currentPlayer="Hola"
	baseStats=GameManager.getBaseStats()
	moneyLabel.text=str(GameManager.getMoney())
	var f = File.new()
	var open_err = f.open(itemListJson, File.READ)
	var itemListDic=parse_json(f.get_as_text())
	upgrade=itemListDic[str(baseStats["level"])]["upgrade"]
	list=itemListDic[str(baseStats["level"])]["list"]
	if baseStats["level"]==0:
		loadUpgrade(upgrade)
	elif baseStats["level"]==5:
		loadItems(false)
	else:
		for i in list:
			allPurchased=allPurchased and baseStats[i["id"]]
		loadItems()

func loadUpgrade(var upgrade):
	var instance=shopUiBtn.instance()
	instance.itemName=upgrade["itemName"]
	instance.price=str(upgrade["price"])
	instance.id="upgrade"
	instance.connect('pressed', self, '_upgrade', [instance])
	itemList.add_child(instance)

func loadItems(var loadUpgradeBool=true):
	baseStats=GameManager.getBaseStats()
	moneyLabel.text=str(GameManager.getMoney())
	if loadUpgradeBool:
		allPurchased=true
		for i in list:
			allPurchased=allPurchased and baseStats[i["id"]]
		if allPurchased and baseStats["level"]!=5:
			loadUpgrade(upgrade)
	for n in itemList.get_children():
		if n.id!="upgrade":
			itemList.remove_child(n)
			n.queue_free()
	for i in list:
		var instance=shopUiBtn.instance()
		instance.itemName=i["itemName"]
		instance.price=str(i["price"])
		instance.id=i["id"]
		instance.purcharsed=baseStats[i["id"]]
		if !instance.purcharsed:
			instance.connect('pressed', self, '_pressed', [instance])
		itemList.add_child(instance)

func _pressed(button):
	if GameManager.getMoney()>int(button.price):
		GameManager.reduceMoney(int(button.price))
		var baseStat=GameManager.purchaseBase(button.id)
		loadItems()

func _upgrade(button):
	if GameManager.getMoney()>int(button.price):
		baseStats["level"]+=1
		for n in itemList.get_children():
			if n.id!="upgrade":
				baseStats[n.id]=false
			itemList.remove_child(n)
			n.queue_free()
		GameManager.reduceMoney(int(button.price))
		moneyLabel.text=str(GameManager.getMoney())
		GameManager.saveBaseStats(baseStats)
		popup.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
