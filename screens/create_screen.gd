extends Node

func _ready() -> void:
	SessionManager.data.connect(on_session_manager_data)
	SessionManager.disconnected.connect(switch_to_lobby_screen)
	SessionManager.error.connect(switch_to_lobby_screen)
	
	%Quit.pressed.connect(func(): SessionManager.disconnect_from_server()) 
	
	throw_dice()
	dasd()

func dasd() -> void:
	for i in Declares.NUMRAZAS:
		%Race.add_item(Declares.race_names[i + 1])
		
	for i in Declares.NUMCLASES:
		%Class.add_item(Declares.class_names[i + 1])
		
	for i in Declares.NUMCIUDADES:
		%Home.add_item(Declares.home_names[i + 1])

func on_session_manager_data(data:PackedByteArray) -> void:
	var stream = StreamPeerBuffer.new()
	stream.data_array = data
	 
	match stream.get_u8(): 
		Enums.ServerPacketID.ErrorMsg:
			Utils.show_message_box("Error", stream.get_utf8_string(), self) 
		Enums.ServerPacketID.DiceRoll:
			handle_dice_roll(DiceRollResponse.unpack(stream))
		_:
			switch_to_game_screen(data)


func handle_dice_roll(p:DiceRollResponse) -> void:
	for i in p.attributes.size():
		%Attributes.get_child(i).text = str(p.attributes[i])

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

func _on_register_pressed() -> void:
	if %Username.text.is_empty():
		Utils.show_message_box("Error", "Ingrese un nombre de personaje", self) 
		return
	
	if %Password.text.is_empty():
		Utils.show_message_box("Error", "Ingrese un password", self)
		return
	
	if %Email.text.is_empty():
		Utils.show_message_box("Error", "Ingrese un email", self)
		return
	
	if %Username.text.length() > 30:
		Utils.show_message_box("Error", "El nombre debe tener menos de 30 letras.", self) 
		return			
	
	if !Utils.is_valid_email(%Email.text):
		Utils.show_message_box("Error", "Ingrese un email valido.", self) 
		return			
	 
	if !Utils.string_has_valid_characters(%Username.text):
		Utils.show_message_box("Error", "Nombre con caracter invalido.", self)  
		return

	if !Utils.string_has_valid_characters(%Password.text):
		Utils.show_message_box("Error", "Password con caracter invalido.", self)   
		return

	if %Password.text != %ConfirmPassword.text:
		Utils.show_message_box("Error", "Las contraseñas no coinciden", self)
		return

	var p = LoginNewCharRequest.new()
	p.username = %Username.text
	p.password = %Password.text
	p.email = %Email.text
	
	p.user_race = %Race.selected + 1
	p.user_gender = %Gender.selected + 1
	p.user_class = %Class.selected + 1
	p.user_home = %Home.selected + 1
	
	SessionManager.send_packet(p)
	
	%Register.disabled = true
	await get_tree().create_timer(1.2).timeout
	%Register.disabled = false
