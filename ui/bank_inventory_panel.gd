extends Panel
class_name BankInventoryPanel 

@export var bank_inventory:InventoryContainer
@export var player_inventory:InventoryContainer
@export var object_info_label:Label

var quantity:int:
	get:
		return %Quantity.value
	set(value):
		%Quantity.value = value

func initialize(game_data:PlayerData) -> void:
	bank_inventory.set_inventory(game_data.bank_inventory) 
	player_inventory.set_inventory(game_data.player_inventory)
    

func _on_store_pressed() -> void:
	var slot := player_inventory.selected_slot
	if quantity == 0 || slot == -1:  
		return  
	
	SessionManager.send_packet(BankDepositRequest.new(slot + 1, quantity))


func _on_retrieve_pressed() -> void:
	var slot := bank_inventory.selected_slot
	if quantity == 0 || slot == -1:  
		return  

	SessionManager.send_packet(BankExtractItemRequest.new(slot + 1, quantity))

func _on_quit_pressed() -> void:
	SessionManager.send_packet(BankEndRequest.new()) 


func _on_player_inventory_slot_selected(slot_index:int) -> void:
	if slot_index < Declares.MAX_INVENTORY_SLOTS_SERVER:
		var item  = player_inventory.inventory.get_item_stack(slot_index).item
		update_object_info(item)
	else:
		clear_object_info()


func _on_bank_inventory_slot_selected(slot_index:int) -> void:
	var item  = bank_inventory.inventory.get_item_stack(slot_index).item
	update_object_info(item)

func update_object_info(item:Item) -> void:
	var text := item.name

	if item.type == Enums.EObjType.WEAPON:
		text += "\nDaño: %d/%d" % [item.min_hit, item.max_hit]

	if item.type == Enums.EObjType.ARMADURA:
		text += "\nDefensa: " + str(item.defense)

	object_info_label.text = text


func clear_object_info() -> void:
	object_info_label.text = ""