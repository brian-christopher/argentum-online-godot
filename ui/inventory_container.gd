extends GridContainer
class_name InventoryContainer

signal slot_pressed(slot_index:int)
signal slot_selected(slot_index:int)

@export var inventory_slot_scene:PackedScene

var selected_slot:int = -1
var inventory:Inventory

func set_inventory(p_inventory:Inventory) -> void:
	inventory = p_inventory
	inventory.slot_changed.connect(on_inventoy_slot_changed)
	
	for i in inventory.get_size():
		var inventory_slot = inventory_slot_scene.instantiate() as InventorySlot
		inventory_slot.slot_index = i
		inventory_slot.pressed.connect(on_slot_pressed.bind(i)) 
		add_child(inventory_slot)
	
func on_inventoy_slot_changed(slot_index, _old_content:ItemStack, new_content:ItemStack) -> void:
	var inventory_slot = get_inventory_slot(slot_index)
	if inventory_slot:
		inventory_slot.set_item(new_content.item)
		inventory_slot.set_quantity(new_content.quantity)
		inventory_slot.set_equipped(new_content.equipped)
	
func get_inventory_slot(slot_index:int) -> InventorySlot:
	for node in get_children():
		if node is InventorySlot && node.slot_index == slot_index:
			return node
	return null

func on_slot_pressed(id:int) -> void: 
	if selected_slot == id:
		slot_pressed.emit(id)
		return
	
	var slot = get_inventory_slot(selected_slot)
	if slot: slot.set_selected(false)
		
	selected_slot = id 
	slot = get_inventory_slot(id)
	if slot:
		slot.set_selected(true)
		slot_selected.emit(id)
