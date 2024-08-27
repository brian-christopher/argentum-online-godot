extends Panel
class_name PlayerInventory

@export var inventory_container:InventoryContainer

var player_data:PlayerData

func set_player_data(player_data:PlayerData) -> void:
	self.player_data = player_data
	inventory_container.set_inventory(player_data.inventory)
	inventory_container.slot_pressed.connect(on_slot_pressed)

func on_slot_pressed(slot_index:int) -> void:
	if slot_index < Declares.MAX_INVENTORY_SLOTS_SERVER:
		var p = UseItemRequest.new()
		p.slot = slot_index + 1
		SessionManager.send_packet(p) 
