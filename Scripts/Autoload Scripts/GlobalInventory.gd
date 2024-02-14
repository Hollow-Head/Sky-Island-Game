extends Node

# TODO Pre created slots in inventory, when a item is created, the item will go to the nearest slot
# TODO and the slot will receive the item specifications, etc.

# TODO Probably will work on that and other things when someone besides me work on the game...

@onready var player : CharacterBody2D = get_node("/root/Main/Player")

@onready var itemScene = preload("res://Scenes/Slot.tscn")
var item

var hasKey01 : bool

# Old function
#func addToInventory(item : PanelContainer):
	#player.inventory.append(item)

func addToInventory(name : String, description : String, texture : Texture):
	item = itemScene.instantiate()
	item.name = name
	item.description = description
	item.get_node("Item").texture = texture
	player.inventory.append(item)
	
	pass

func removeFromInventory(name : String):
	for N in player.inventory.size():
		if name in player.inventory[N].name:
			player.inventory[N].queue_free()
			player.inventory.remove_at(N)
			return
	printerr("Couldn't find -> " + name + " <- in player inventory")
