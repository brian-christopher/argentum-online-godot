extends RefCounted
class_name PlayerData


var inventory:Inventory
var user_navegando:bool


func _init() -> void:
	inventory = Inventory.new(Declares.MAX_INVENTORY_SLOTS)
