extends Control

# looks up player's inventory by importing resource
# Inv class was declared in "inventory.gd"
@onready var inv: Inv = preload("res://inventory/playerinv.tres")
# get all slots in grid container
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

# checks if inventory is open
var is_open = false

func _ready():
	update_slots()
	close()

func update_slots():
	# class Inv has attribute "items"
	for i in range(min(inv.items.size(), slots.size())):
		slots[i].update(inv.items[i])
		

func _process(delta):
	if Input.is_action_just_pressed("i"):
		if is_open:
			close()
		else:
			open()

func open():
	# print("inventory") # for debugging
	self.visible = true
	is_open = true
	
func close():
	visible = false
	is_open = false
	
