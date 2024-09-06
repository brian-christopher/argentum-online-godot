extends Panel
class_name NpcInventoryPanel

@export var npc_inventory_list:ItemListInventoryView
@export var player_inventory_list:ItemListInventoryView

var quantity:int:
	get:
		return %Quantity.value
	set(value):
		%Quantity.value = value
 
func initialize(game_data:PlayerData) -> void:
	npc_inventory_list.set_inventory(game_data.npc_inventory) 
	player_inventory_list.set_inventory(game_data.inventory)
 
func _on_buy_pressed() -> void: 
	var selected_item = npc_inventory_list.get_selected_item()
	if quantity == 0 || selected_item == -1:  
		return 
		
	SessionManager.send_packet(CommerceBuyRequest.new(selected_item + 1, quantity))

func _on_sell_pressed() -> void: 
	var selected_item = player_inventory_list.get_selected_item() 
	if quantity == 0 || selected_item == -1:  
		return 
		
	SessionManager.send_packet(CommerceSellRequest.new(selected_item + 1, quantity))

func _on_quit_pressed() -> void:
	SessionManager.send_packet(CommerceEndRequest.new()) 
