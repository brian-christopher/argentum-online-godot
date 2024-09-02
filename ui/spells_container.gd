extends PanelContainer
class_name SpellsContainer

@export var item_list:ItemList 
var player_data:PlayerData
var ui_controller:UIController

func _ready() -> void:
	for i in Declares.MAXHECHI:
		item_list.add_item("(None)")
		
func initialize(p_player_data:PlayerData, p_ui_controller:UIController) -> void:
	player_data = p_player_data
	ui_controller = p_ui_controller

	player_data.spell_changed.connect(on_player_spell_changed)

func _on_cast_pressed() -> void:
	if selected_item() == -1 : return
	if item_list.get_item_text(selected_item()) == "(None)" : return
	
	var p = CastSpellRequest.new()
	p.slot = selected_item() + 1
	SessionManager.send_packet(p)
	
	p = WorldRequest.new()
	p.skill = Enums.Skill.MAGIA
	SessionManager.send_packet(p)

func _on_info_pressed() -> void:
	if selected_item() == -1: return
	var p = SpellInfoRequest.new()
	p.slot = selected_item() + 1
	
	SessionManager.send_packet(p)
	
func on_player_spell_changed(slot:int, id:int, name:String) -> void:
	item_list.set_item_text(slot, name)
	
func selected_item() -> int:
	var selected_items = item_list.get_selected_items()
	if selected_items.is_empty():
		return -1
	return selected_items[0]


func _on_move_down_pressed() -> void:
	if selected_item() != -1 && selected_item() + 1 ==  Declares.MAXHECHI: return
	item_list.move_item(selected_item(), selected_item() + 1)
	item_list.select(selected_item())
	SessionManager.send_packet(MoveSpellRequest.new(true, selected_item() + 1))

func _on_move_up_pressed() -> void:
	if selected_item() <= 0: return
	item_list.move_item(selected_item(), selected_item() - 1)
	item_list.select(selected_item())
	SessionManager.send_packet(MoveSpellRequest.new(false, selected_item() + 1))
