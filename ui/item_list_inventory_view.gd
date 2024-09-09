extends ItemList
class_name ItemListInventoryView

var inventory:Inventory

func set_inventory(p_inventory:Inventory) -> void:
	inventory = p_inventory
	inventory.slot_changed.connect(on_inventoy_slot_changed)
	
	for i in inventory.get_size():
		add_item("Nada")

func on_inventoy_slot_changed(slot_index, _old_content:ItemStack, new_content:ItemStack) -> void:
	var item := new_content.item
	
	set_item_text(slot_index, item.name if !item.name.is_empty() else "Nada")
	set_item_icon(slot_index, item.icon) 

func get_selected_item() -> int:
	var selected_items := get_selected_items()
	
	if selected_items.is_empty():
		return -1
	return selected_items[0]
