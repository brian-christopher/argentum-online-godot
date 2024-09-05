extends CanvasLayer
class_name UIController

@export var rich_text:RichTextLabel
@export var send_text:LineEdit
@export var name_label:Label
@export var level_label:Label
@export var gold_label:Label

@export var hp_bar:StatsBar
@export var mp_bar:StatsBar
@export var sta_bar:StatsBar
@export var thirst_bar:StatsBar
@export var hunger_bar:StatsBar
@export var experience_bar:StatsBar

@export var player_inventory:PlayerInventory
@export var spells_container:SpellsContainer
@export var view_container:SubViewportContainer
var player_data:PlayerData

func set_player_data(p_player_data:PlayerData) -> void:
	player_data = p_player_data 
	player_data.property_changed.connect(on_player_property_changed)
	
	player_inventory.set_player_data(player_data)
	spells_container.initialize(player_data, self)  
	
func append_text(text:String) -> void:
	rich_text.append_text(text + "\n")
	
func add_to_console(message:String, color:Color, bold:bool, italic:bool) -> void:
	message = "[color=%s]%s[/color]" % [color.to_html(), message]  
	if italic:
		message = "[i]%s[/i]" % message 
	if bold:
		message = "[b]%s[/b]" % message  
	rich_text.append_text(message + "\n")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed && event.keycode == KEY_ENTER:
			send_text.show()
			send_text.grab_focus()
			
	if event.is_action_pressed("attack"):
		SessionManager.send_packet(AttackRequest.new())
	if event.is_action_pressed("equip_object"):
		equip_object()
	if event.is_action_pressed("pick_up"):
		pick_up()
	if event.is_action_pressed("combat_mode_toggle"):
		SessionManager.send_packet(CombatModeToggleRequest.new())
	if event.is_action_pressed("hide"):
		hide_player()
	if event.is_action_pressed("use_object"):
		use_object()
	if event.is_action_pressed("meditate"):
		meditate()
			
func get_tile_mouse_position(transform_2d:Transform2D, mouse_position:Vector2) -> Vector2:
	return (transform_2d.inverse() * mouse_position / Declares.TILE_SIZE).ceil()
			
func _on_main_view_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_position = get_tile_mouse_position(%MainCamera.get_canvas_transform(), event.position) 
		
		if event.double_click && event.pressed:
			SessionManager.send_packet(DoubleClickRequest.new(
				mouse_position.x,
				mouse_position.y
			)) 
			return
		
		if player_data.using_skill == Enums.Skill.NONE && event.pressed:
			SessionManager.send_packet(LeftClickRequest.new(
				mouse_position.x,
				mouse_position.y
			)) 
		else:
			SessionManager.send_packet(WorkLeftClickRequest.new(
				mouse_position.x,
				mouse_position.y,
				player_data.using_skill
			)) 
			set_mouse_cursor_shape(Control.CURSOR_ARROW)
			player_data.using_skill = Enums.Skill.NONE
				
func _on_send_text_text_submitted(new_text: String) -> void:
	if new_text.is_empty():
		return
	send_text.text = ""
	send_text.hide()
	
	var p = TalkRequest.new()
	p.message = new_text
	SessionManager.send_packet(p)

func on_player_property_changed(property_name:String) -> void:
	match property_name:
		"name":
			set_player_name(player_data.name)
		"hp", "max_hp":
			hp_bar.set_bar_value(player_data.hp, player_data.max_hp)
		"mp", "max_mp":
			mp_bar.set_bar_value(player_data.mp, player_data.max_mp)
		"sta", "max_sta":
			sta_bar.set_bar_value(player_data.sta, player_data.max_sta)
		"thirst":
			thirst_bar.set_bar_value(player_data.thirst, 100)
		"hunger":
			hunger_bar.set_bar_value(player_data.hunger, 100)
		"experience", "experience_for_next_level":
			experience_bar.set_bar_value(player_data.experience, player_data.experience_for_next_level)
		"level":
			level_label.text = "Level: %d" % player_data.level
		"gold":
			gold_label.text = str(player_data.gold)
		_:
			print(property_name) 
			
func set_mouse_cursor_shape(shape:int) -> void:
	Input.set_default_cursor_shape(shape) 

func equip_object() -> void:
	var selected_slot = player_inventory.inventory_container.selected_slot
	if selected_slot >= 0 && selected_slot < Declares.MAX_INVENTORY_SLOTS_SERVER:
		var p = EquipItemRequest.new()
		p.slot = selected_slot + 1
		SessionManager.send_packet(p) 

func pick_up() -> void:
	SessionManager.send_packet(PickUpRequest.new())

func hide_player() -> void:
	var p = WorldRequest.new()
	p.skill = Enums.Skill.OCULTARSE
	
	SessionManager.send_packet(p)

func use_object() -> void:
	var selected_slot = player_inventory.inventory_container.selected_slot
	if selected_slot >= 0 && selected_slot < Declares.MAX_INVENTORY_SLOTS_SERVER:
		var p = UseItemRequest.new()
		p.slot = selected_slot + 1
		SessionManager.send_packet(p) 
		
func meditate() -> void:
	if player_data.max_mp != 0:
		SessionManager.send_packet(MeditateRequest.new()) 

func set_player_name(p_name:String) -> void:
	name_label.text = p_name

func _on_show_inventory_pressed() -> void:
	spells_container.hide()
	player_inventory.show()

func _on_show_spells_pressed() -> void:
	player_inventory.hide()
	spells_container.show()
