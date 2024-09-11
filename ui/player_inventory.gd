extends Panel
class_name PlayerInventory

@export var _inventory_container:InventoryContainer

var player_data:PlayerData

var selected_slot:int:
	get: 
		return _inventory_container.selected_slot

func set_player_data(p_player_data:PlayerData) -> void:
	player_data = p_player_data
	
	_inventory_container.set_inventory(player_data.player_inventory)
	_inventory_container.slot_pressed.connect(on_slot_pressed)

func on_slot_pressed(slot_index:int) -> void:
	if slot_index < Declares.MAX_INVENTORY_SLOTS_SERVER:
		var p = UseItemRequest.new()
		p.slot = slot_index + 1
		SessionManager.send_packet(p) 
