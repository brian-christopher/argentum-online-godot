extends RefCounted
class_name Inventory

signal slot_changed(index:int, old_content:ItemStack, new_content:ItemStack)

var _slots:Array[ItemStack]

func _init(size:int) -> void:
	_slots.resize(size)
	_slots.fill(ItemStack.new(Item.new(), 0, false))
	
func get_size() -> int:
	return _slots.size()

func get_item_stack(index:int) -> ItemStack:
	return ItemStack.new(_slots[index].item, _slots[index].quantity, _slots[index].equipped)

func set_item_stack(index:int, item_stack:ItemStack) -> void:
	var old_content = _slots[index]
	var new_content = item_stack
	
	_slots[index] = new_content
	slot_changed.emit(index, old_content, new_content)
