extends Panel
class_name NpcInventoryPanel

@export var npc_inventory_list:ItemListInventoryView
@export var player_inventory_list:ItemListInventoryView
@export var object_info_label:Label

var quantity:int:
	get:
		return %Quantity.value
	set(value):
		%Quantity.value = value
 
func initialize(game_data:PlayerData) -> void:
	npc_inventory_list.set_inventory(game_data.npc_inventory) 
	player_inventory_list.set_inventory(game_data.player_inventory)
 
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
 

func _on_player_inventory_item_selected(index:int) -> void:
	if index < Declares.MAX_INVENTORY_SLOTS_SERVER:
		var item_stack  := player_inventory_list.inventory.get_item_stack(index)
		_update_object_info(item_stack.item, item_stack.quantity)
	else:
		clear_object_info()


func _on_npc_inventory_item_selected(index:int) -> void:
	var item_stack  := npc_inventory_list.inventory.get_item_stack(index)
	_update_object_info(item_stack.item, item_stack.quantity)


func _update_object_info(item:Item, p_quantity:int) -> void:
	var text := "Cantidad: " + str(p_quantity)

	if item.type == Enums.EObjType.WEAPON:
		text += "\nDaño: %d/%d" % [item.min_hit, item.max_hit]

	if item.type == Enums.EObjType.ARMADURA:
		text += "\nDefensa: " + str(item.defense)

	object_info_label.text = text


func clear_object_info() -> void:
	object_info_label.text = ""