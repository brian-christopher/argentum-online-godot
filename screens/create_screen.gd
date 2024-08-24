extends Node

func _ready() -> void:
	SessionManager.data.connect(on_session_manager_data)
	SessionManager.disconnected.connect(switch_to_lobby_screen)
	SessionManager.error.connect(switch_to_lobby_screen)
	
	throw_dice()
 
func on_session_manager_data(data:PackedByteArray) -> void:
	var stream = StreamPeerBuffer.new()
	stream.data_array = data
	 
	match stream.get_u8():
		Enums.ServerPacketID.Logged:
			switch_to_game_screen(data)
		Enums.ServerPacketID.ErrorMsg:
			Utils.show_message_box("Error", stream.get_utf8_string(), self) 
		Enums.ServerPacketID.DiceRoll:
			handle_dice_roll(DiceRollResponse.unpack(stream))

func handle_dice_roll(p:DiceRollResponse) -> void:
	pass

func switch_to_lobby_screen() -> void:
	var screen = load("res://screens/lobby_screen.tscn").instantiate() 
	ScreenManager.switch_screen(screen) 

func switch_to_game_screen(data:PackedByteArray) -> void:
	var screen = load("res://screens/game_screen.tscn").instantiate()
	screen.incoming_data.push_back(data)
	ScreenManager.switch_screen(screen) 

func throw_dice() -> void:
	var p = ThrowDicesRequest.new()
	SessionManager.send_packet(p)
