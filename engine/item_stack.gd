extends RefCounted
class_name ItemStack

var item:Item
var quantity:int
var equipped:bool

func _init(p_item:Item, p_quantity:int, p_equipped:bool) -> void:
	item = p_item
	quantity = p_quantity
	equipped = p_equipped
