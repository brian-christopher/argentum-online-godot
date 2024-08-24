extends Node

@export var login_panel:LoginPanel 

enum State{
	None,
	Login,
	Register
} 
var current_state:int = State.None

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SessionManager.data.connect(on_session_manager_data)
	SessionManager.connected.connect(on_session_manager_connected)
#	SessionManager.connect_to_server("127.0.0.1", 7666) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_session_manager_connected() -> void:
	var p = LoginExistingCharRequest.new()
	p.username = "asd"
	p.password = "123123"	
	
	SessionManager.send_packet(p)

func on_session_manager_data(data:PackedByteArray) -> void:
	var screen = load("res://screens/game_screen.tscn").instantiate()
	screen.incoming_data.push_back(data)
	
	ScreenManager.switch_screen(screen) 

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
