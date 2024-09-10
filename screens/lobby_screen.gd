extends Node

@export var login_panel:LoginPanel 

enum State{
	None,
	Login,
	Register
} 
var current_state:int = State.None
 
func _ready() -> void:
	SessionManager.connected.connect(on_session_manager_connected) 
	SessionManager.data.connect(on_session_manager_data)
	
	SessionManager.disconnected.connect(on_session_disconnected)
	SessionManager.error.connect(on_session_disconnected)
	
func on_session_manager_connected() -> void:
	if current_state == State.Register:
		switch_to_register_screen() 
	else:
		send_login_request() 
		
func on_session_disconnected() -> void:
	current_state = State.None
	login_panel.enable_auth_buttons()
	SessionManager.disconnect_from_server()
	
func on_session_manager_data(data:PackedByteArray) -> void:
	var stream = StreamPeerBuffer.new()
	stream.data_array = data
	
	var packet_id = stream.get_u8()
	
	match packet_id:
		Enums.ServerPacketID.Logged:
			switch_to_game_screen(data)
		Enums.ServerPacketID.ErrorMsg:
			login_failed(stream.get_utf8_string())
		_:
			print_debug(packet_id)
		
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE:
			quit()

func quit() -> void:
	get_tree().quit()
	
func _on_login_panel_login_button_pressed() -> void:
	connect_to_server(State.Login)

func _on_login_panel_register_button_pressed() -> void:
	connect_to_server(State.Register)

func _on_login_panel_error(error_message: String) -> void:
	Utils.show_message_box("Error", error_message, self)
	
func connect_to_server(state:int) -> void:
	login_panel.disable_auth_buttons()
	current_state = state

	var endpoint = get_ip_and_port()
	SessionManager.connect_to_server(endpoint.ip, endpoint.port)
 
func get_ip_and_port() -> Dictionary:
	return {
		"ip" = %Address.text,
		"port" = %Port.value
	}
	
func switch_to_register_screen() -> void:
	var screen = load("res://screens/create_screen.tscn").instantiate() 
	ScreenManager.switch_screen(screen) 

func switch_to_game_screen(stream:PackedByteArray) -> void:
	var screen = load("res://screens/game_screen.tscn").instantiate()
	screen.incoming_data.push_back(stream)
	ScreenManager.switch_screen(screen) 

func send_login_request() -> void: 
	var p = LoginExistingCharRequest.new()
	p.username = login_panel.get_username()
	p.password = login_panel.get_password()
	
	SessionManager.send_packet(p)
	
func login_failed(error_message:String) -> void:
	Utils.show_message_box("Error", error_message, self)
	current_state = State.None
	login_panel.enable_auth_buttons()
	SessionManager.disconnect_from_server()
