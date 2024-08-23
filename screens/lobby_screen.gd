extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SessionManager.data.connect(on_session_manager_data)
	SessionManager.connected.connect(on_session_manager_connected)
	SessionManager.connect_to_server("127.0.0.1", 7666) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_session_manager_connected() -> void:
	var p = LoginExistingCharRequest.new()
	p.username = "tato"
	p.password = "123123"	
	
	SessionManager.send_packet(p)

func on_session_manager_data(data:PackedByteArray) -> void:
	var screen = load("res://screens/game_screen.tscn").instantiate()
	screen.incoming_data.push_back(data)
	
	ScreenManager.switch_screen(screen) 
