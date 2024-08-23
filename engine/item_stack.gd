extends RefCounted
class_name ItemStack

var item:Item
var quantity:int
var equipped:bool

func _init(item:Item, quantity:int, equipped:bool) -> void:
	self.item = item
	self.quantity = quantity
	self.equipped = equipped
