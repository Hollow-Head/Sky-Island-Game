extends CharacterBody2D

const SPEED = 700.0

@onready var UI = get_node("UI")

@onready var inventoryScene = preload("res://Scenes/Inventory.tscn")
var inventory : Array
var inventoryNode : Control
var hasInventory := false

func _process(delta):
	handleInput()
	#for N in inventory:
		#print(inventory)

func _physics_process(delta):
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	

# We can put all of the inventory functions at GlobalInventory, but now it's here for the tests
func handleInput():
	if Input.is_action_just_pressed("Inventory") and not hasInventory:
		hasInventory = true
		inventoryNode = inventoryScene.instantiate()
		UI.add_child(inventoryNode)
		loadInventory()
		inventoryNode.global_position.x = global_position.x - (inventoryNode.size.x / 2)
		inventoryNode.global_position.y = global_position.y - (inventoryNode.size.y / 2)
	elif (Input.is_action_just_pressed("Inventory") or Input.is_action_just_pressed("Escape")) and hasInventory:
		hasInventory = false
		deloadInventory()
		inventoryNode.queue_free()

func loadInventory():
	for N in inventory.size():
		#print(inventory[N].name)
		inventoryNode.get_node("Slots").add_child(inventory[N])
	printInventory()

# The item must be removed, otherwise, it'll be fully deleted by the queue_free of the inventory node
func deloadInventory():
	for N in inventory.size():
		inventoryNode.get_node("Slots").remove_child(inventory[N])

# For debugging
func printInventory():
	var array := inventoryNode.get_node("Slots").get_children()
	for N in array.size():
		print(array[N].name)
