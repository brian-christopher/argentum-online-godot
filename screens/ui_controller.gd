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
@export var bank_inventory:BankInventoryPanel
@export var npc_inventory:NpcInventoryPanel
@export var spells_container:SpellsContainer
@export var view_container:SubViewportContainer

var player_data:PlayerData

func set_player_data(p_player_data:PlayerData) -> void:
	player_data = p_player_data 
	player_data.property_changed.connect(on_player_property_changed)
	
	player_inventory.set_player_data(player_data)
	spells_container.initialize(player_data, self)  
	
	npc_inventory.initialize(player_data)
	bank_inventory.initialize(player_data)

	
func append_text(text:String) -> void:
	rich_text.append_text(text + "\n")

	
func add_to_console(message:String, color:Color = Color.WHITE, bold:bool = false, italic:bool = false) -> void:
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
	if event.is_action_pressed("exit_game"):
		exit_game()
	if event.is_action_pressed("request_refresh"):
		request_position()
	if event.is_action_pressed("tam_animal"):
		tam_animal()
	if event.is_action_pressed("steal"):
		steal()
	if event.is_action_pressed("take_screenshot"):
		take_screenshot()
	if event.is_action_pressed("drop_object"):
		drop_object()

			
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
	
	Commands.parse_user_command(new_text, player_data, self)


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
	var selected_slot = player_inventory.selected_slot
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
	var selected_slot = player_inventory.selected_slot

	if selected_slot >= 0 && selected_slot < Declares.MAX_INVENTORY_SLOTS_SERVER:
		var p = UseItemRequest.new()
		p.slot = selected_slot + 1
		SessionManager.send_packet(p) 

		
func meditate() -> void:
	if player_data.max_mp != 0:
		SessionManager.send_packet(MeditateRequest.new()) 


func exit_game() -> void:
	SessionManager.send_packet(\
		SendSinglePacketRequest.new(Enums.ClientPacketID.Quit))


func request_position() -> void:
	SessionManager.send_packet(\
		SendSinglePacketRequest.new(Enums.ClientPacketID.RequestPositionUpdate))


func tam_animal() -> void:
	SessionManager.send_packet(\
		WorldRequest.new(Enums.Skill.DOMAR))


func steal() -> void:
	SessionManager.send_packet(\
		WorldRequest.new(Enums.Skill.ROBAR))


func take_screenshot() -> void:
	await RenderingServer.frame_post_draw
	
	var viewport = get_viewport()
	var img = viewport.get_texture().get_image()
	var img_name = str(Time.get_unix_time_from_system()) + ".png"

	img.save_png("user://screenshots/" + img_name)
	add_to_console("Foto tomada: " + img_name, Color.AQUAMARINE, false, true)


func drop_object() -> void:
	var selected_slot = player_inventory.selected_slot
	if selected_slot == -1:
		return 

	if player_data.player_inventory.get_item_stack(selected_slot).item.id == 0:
		return

	create_drop_item_dialig_box("Tirar Item", func(amount): 
		SessionManager.send_packet(DropRequest.new(selected_slot + 1, amount))
		)

func set_player_name(p_name:String) -> void:
	name_label.text = p_name


func show_npc_inventory() -> void:
	npc_inventory.show()
	npc_inventory.clear_object_info()
	npc_inventory.quantity = 1


func hide_npc_inventory() -> void:
	npc_inventory.hide()


func show_bank_inventory() -> void:
	bank_inventory.show()
	bank_inventory.clear_object_info()
	bank_inventory.quantity = 1


func hide_bank_inventory() -> void:
	bank_inventory.hide()


func _on_show_inventory_pressed() -> void:
	spells_container.hide()
	player_inventory.show()


func _on_show_spells_pressed() -> void:
	player_inventory.hide()
	spells_container.show()


func _on_gold_icon_pressed() -> void:
	create_drop_item_dialig_box("Tirar Oro", func(amount):
		if player_data.gold <= amount:
			amount = player_data.gold 
		SessionManager.send_packet(DropRequest.new(Declares.FLAGORO, amount))
		)


func create_drop_item_dialig_box(title:String, accept_callable:Callable) -> void:
	var dialog = ConfirmationDialog.new()
	var spin_box = SpinBox.new()
	spin_box.max_value = 10000
	spin_box.min_value = 0
	spin_box.value = 1
	dialog.add_child(spin_box)  

	add_child(dialog) 
	dialog.unresizable = true
	dialog.dialog_hide_on_ok = false
	dialog.title = title
	dialog.cancel_button_text = "Tirar todo"

	dialog.get_cancel_button()\
		.pressed.connect(func(): dialog.queue_free())

	dialog.canceled.connect(func(): 
		accept_callable.call(10000)
		dialog.queue_free())
	
	dialog.confirmed.connect(func():
		accept_callable.call(spin_box.value)
		dialog.queue_free()) 

	dialog.popup_centered()