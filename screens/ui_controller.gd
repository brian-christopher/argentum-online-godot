extends CanvasLayer
class_name UIController

@export var rich_text:RichTextLabel
@export var send_text:LineEdit
@export var player_inventory:PlayerInventory


func append_text(text:String) -> void:
	rich_text.append_text(text + "\n")
	
func add_to_console(message:String, color:Color, bold:bool, italic:bool) -> void:
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
		pass
	if event.is_action_pressed("combat_mode_toggle"):
		SessionManager.send_packet(CombatModeToggleRequest.new())
			
func get_tile_mouse_position(transform_2d:Transform2D, mouse_position:Vector2) -> Vector2:
	return (transform_2d.inverse() * mouse_position / Declares.TILE_SIZE).ceil()
			
func _on_main_view_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_position = get_tile_mouse_position(%MainCamera.get_canvas_transform(), event.position) 
		if event.pressed:
			var p = LeftClickRequest.new()
			p.x = mouse_position.x
			p.y = mouse_position.y 
			SessionManager.send_packet(p)
			
		if event.double_click:
			var p = DoubleClickRequest.new()
			p.x = mouse_position.x
			p.y = mouse_position.y 
			SessionManager.send_packet(p)
				
func _on_send_text_text_submitted(new_text: String) -> void:
	if new_text.is_empty():
		return
	send_text.text = ""
	send_text.hide()
	
	var p = TalkRequest.new()
	p.message = new_text
	SessionManager.send_packet(p)

func equip_object() -> void:
	var selected_slot = player_inventory.inventory_container.selected_slot
	if selected_slot >= 0 && selected_slot < Declares.MAX_INVENTORY_SLOTS_SERVER:
		var p = EquipItemRequest.new()
		p.slot = selected_slot + 1
		SessionManager.send_packet(p) 
