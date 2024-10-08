extends Node

@export var ui_controller:UIController
@export var main_camera:Camera2D
@export var world:World

@export var music_stream_player:AudioStreamPlayer 

var incoming_data:Array[PackedByteArray] 
var main_character_index:int = -1

var player_data:PlayerData = PlayerData.new()

var input_map = {
	"walk_right" : Enums.Heading.EAST,
	"walk_left"  : Enums.Heading.WEST,
	"walk_up"    : Enums.Heading.NORTH,
	"walk_down"  : Enums.Heading.SOUTH,
}

func _ready() -> void: 
	SessionManager.data.connect(on_session_manager_data)
	SessionManager.disconnected.connect(on_session_manager_disconnected)
	SessionManager.error.connect(on_session_manager_disconnected)
	 
	ui_controller.set_player_data(player_data)
	 
func on_session_manager_data(data:PackedByteArray) -> void:
	incoming_data.push_back(data)

func on_session_manager_disconnected() -> void:
	var screen = load("res://screens/lobby_screen.tscn").instantiate() 
	SessionManager.disconnect_from_server()
	ScreenManager.switch_screen(screen) 

func _process(_delta: float) -> void:
	check_keys()
	camera_follow_player()
			
func check_keys() -> void:
	var character = world.get_character_by_id(main_character_index)
	if character == null: 
		return
	
	if player_data.comerciando:
		return
	 
	#If frmForo.Visible Then Exit Sub
	#If pausa Then Exit Sub
	if character.is_moving: return
	#If Not UserEstupido Then
	
	for k in input_map:
		if Input.is_action_pressed(k): 
			move_to(character, input_map[k])
			return


func legal_position(x:int, y:int) -> bool:
	if !Utils.in_map_bounds(x, y):
		return false
	
	if world.map.is_tile_blocked(x, y):
		return false
	
	if world.get_character_at(x, y):
		return false
	
	if player_data.user_navegando != world.map.is_water_at_position(x, y):
		return false
	return true


func move_to(character:CharacterController, heading:int) -> void:
	var legal_ok := false
	
	# If Cartel Then Cartel = False
	match heading:
		Enums.Heading.NORTH:
			legal_ok = legal_position(character.grid_position.x, character.grid_position.y - 1)
		Enums.Heading.EAST:
			legal_ok = legal_position(character.grid_position.x + 1, character.grid_position.y)
		Enums.Heading.SOUTH:
			legal_ok = legal_position(character.grid_position.x, character.grid_position.y + 1)
		Enums.Heading.WEST:
			legal_ok = legal_position(character.grid_position.x - 1, character.grid_position.y)
	
	#If LegalOk And Not UserParalizado Then
	if legal_ok:
		character.move_to_heading(heading)
		var p = WalkRequest.new()
		p.heading = heading
		SessionManager.send_packet(p)
		
		character.heading = heading
		character.grid_position += Vector2i(Utils.heading_to_vector(heading))
		do_pasos_fx(character)
	else:
		if character.heading != heading:
			var p = ChangeHeadingRequest.new()
			p.heading = heading
			SessionManager.send_packet(p)
	
func _physics_process(_delta: float) -> void:
	process_incoming_data()
	
func camera_follow_player() -> void:
	var character = world.get_character_by_id(main_character_index)
	if character:
		main_camera.position = character.position
	

func do_pasos_fx(character:CharacterController) -> void:
	if !player_data.user_navegando:
		character.pie = !character.pie
		if character.pie:
			play_sound("23.wav")	
		else:
			play_sound("24.wav")
	else:
		pass
	#	play_sound("50.wav")
	
func play_sound(filename:String, _pos:Vector2 = Vector2.ZERO) -> void:
	var audio_stream = AudioStreamPlayer.new()
	audio_stream.stream = load("res://assets/sounds/" + filename)
	audio_stream.bus = "sound"
	audio_stream.finished.connect(func(): audio_stream.queue_free())
	get_parent().add_child(audio_stream)
	audio_stream.play()	

#region NETWORK
func process_incoming_data() -> void:
	while !incoming_data.is_empty():
		var stream := StreamPeerBuffer.new()
		stream.data_array = incoming_data.pop_front()
		
		handle_incoming_data(stream)
	
func handle_incoming_data(stream:StreamPeerBuffer) -> void:
	var packet_names = Enums.ServerPacketID.keys()
	var ids = []
	
	while stream.get_position() < stream.get_size():
		var packet_id = stream.get_u8()
		ids.push_back(packet_names[packet_id])
		var packet_name = packet_names[packet_id]
		
		match packet_id:
			Enums.ServerPacketID.Logged:
				handle_logged(stream.get_utf8_string())
				pass

			Enums.ServerPacketID.ResuscitationSafeOff:
				pass

			Enums.ServerPacketID.ResuscitationSafeOn:
				pass

			Enums.ServerPacketID.DumbNoMore:
				pass

			Enums.ServerPacketID.TradeOK:
				pass

			Enums.ServerPacketID.BankOK:
				pass

			Enums.ServerPacketID.UserIndexInServer:
				stream.get_16()

			Enums.ServerPacketID.DumbNoMore:
				pass 

			Enums.ServerPacketID.SafeModeOff:
				pass 

			Enums.ServerPacketID.SafeModeOn:
				pass   

			Enums.ServerPacketID.RemoveDialogs:
				pass   	

			Enums.ServerPacketID.RainToggle:
				pass
				
			Enums.ServerPacketID.MeditateToggle:
				pass

			Enums.ServerPacketID.Disconnect:
				pass

			Enums.ServerPacketID.BankInit:
				handle_bank_init()

			Enums.ServerPacketID.BankEnd:
				handle_bank_end()

			Enums.ServerPacketID.CommerceInit:
				handle_commerce_init()

			Enums.ServerPacketID.CommerceEnd:
				handle_commerce_end()				
				
			Enums.ServerPacketID.WorkRequestTarget:
				Handle_work_request_target(WorkRequestTargetResponse.unpack(stream))

			Enums.ServerPacketID.NavigateToggle:
				handle_navigate_toggle()

			Enums.ServerPacketID.UpdateExp:
				handle_update_exp(stream.get_32())

			Enums.ServerPacketID.UserSwing:
				handle_user_swing()

			Enums.ServerPacketID.UserHitNPC:
				handle_user_hit_npc(stream.get_32())

			Enums.ServerPacketID.UpdateHP:
				handle_update_hp(stream.get_16())

			Enums.ServerPacketID.NPCHitUser:
				handle_npc_hit_user(NPCHitUserResponse.unpack(stream))

			Enums.ServerPacketID.NPCSwing:
				handle_npc_swing()

			Enums.ServerPacketID.NPCKillUser:
				handle_npc_kill_user()

			Enums.ServerPacketID.CharacterChange:
				handle_character_change(CharacterChangeResponse.unpack(stream))

			Enums.ServerPacketID.UpdateSta:
				handle_update_sta(UpdateStaResponse.unpack(stream))

			Enums.ServerPacketID.UpdateMana:
				handle_update_mana(stream.get_16())

			Enums.ServerPacketID.PosUpdate:
				handle_pos_update(PosUpdateResponse.unpack(stream))

			Enums.ServerPacketID.BlockPosition:
				handle_block_position(BlockPositionResponse.unpack(stream))	

			Enums.ServerPacketID.ObjectCreate:
				handle_object_create(ObjectCreateResponse.unpack(stream))	
				
			Enums.ServerPacketID.ObjectDelete:
				handle_object_delete(ObjectDeleteResponse.unpack(stream))
				
			Enums.ServerPacketID.ChatOverHead:
				handle_message_chat_over_head(MessageChatOverHeadResponse.unpack(stream))

			Enums.ServerPacketID.UpdateTagAndStatus:
				handle_update_tag_and_status(UpdateTagAndStatusResponse.unpack(stream))

			Enums.ServerPacketID.ShowMessageBox:
				handle_show_message_box(stream.get_utf8_string())

			Enums.ServerPacketID.ConsoleMsg: 
				handle_console_msg(ConsoleMsgResponse.unpack(stream))

			Enums.ServerPacketID.CharacterMove: 
				handle_character_move(CharacterMoveResponse.unpack(stream))

			Enums.ServerPacketID.PlayWave:
				handle_play_wave(PlayWaveResponse.unpack(stream))

			Enums.ServerPacketID.LevelUp:
				handle_level_up(stream.get_16())

			Enums.ServerPacketID.UpdateGold:
				handle_update_gold(stream.get_32())

			Enums.ServerPacketID.SendSkills:
				handle_send_skills(SendSkillsResponse.unpack(stream))

			Enums.ServerPacketID.GuildChat:	
				handle_guild_chat(stream.get_utf8_string())

			Enums.ServerPacketID.UserCharIndexInServer:
				handle_user_char_index_in_server(stream.get_16())

			Enums.ServerPacketID.UpdateHungerAndThirst:
				update_hunger_and_thrist(UpdateHungerAndThirstResponse.unpack(stream)) 

			Enums.ServerPacketID.UpdateUserStats:
				handle_update_stats(UpdateUserStatsResponse.unpack(stream))

			Enums.ServerPacketID.CreateFX:
				handle_create_fx(CreateFXResponse.unpack(stream))

			Enums.ServerPacketID.SetInvisible:
				handle_set_invisible(SetInvisibleResponse.unpack(stream))

			Enums.ServerPacketID.CharacterCreate:
				handle_character_create(CharacterCreateResponse.unpack(stream))

			Enums.ServerPacketID.AreaChanged:
				handle_area_change(AreaChangedResponse.unpack(stream)) 

			Enums.ServerPacketID.PlayMIDI:
				handle_play_midi(PlayMIDIResponse.unpack(stream))

			Enums.ServerPacketID.ChangeMap:
				handle_change_map(ChangeMapResponse.unpack(stream)) 

			Enums.ServerPacketID.ChangeInventorySlot:
				handle_change_inventory_slot(ChangeInventorySlotResponse.unpack(stream))
				
			Enums.ServerPacketID.ChangeNPCInventorySlot:
				handle_change_npc_inventory_slot(ChangeNPCInventorySlotResponse.unpack(stream))	
			
			Enums.ServerPacketID.ChangeBankSlot:
				handle_change_bank_slot(ChangeBankSlotResponse.unpack(stream))

			Enums.ServerPacketID.ChangeSpellSlot:
				handle_change_spell_slot(ChangeSpellSlotResponse.unpack(stream))

			Enums.ServerPacketID.RemoveCharDialog:
				handle_remove_char_dialog(stream.get_16())

			Enums.ServerPacketID.CharacterRemove:
				handle_character_remove(stream.get_16())

			_:
				print_debug(packet_name)
				return
				
func handle_remove_char_dialog(_char_index:int) -> void:
	pass
	
func handle_update_sta(p:UpdateStaResponse) -> void:
	player_data.sta = p.min_sta
	
func handle_update_gold(gold:int) -> void:
	player_data.gold = gold

func handle_character_remove(char_index:int) -> void:
	world.character_remove(char_index)

func handle_character_change(p:CharacterChangeResponse) -> void:
	var character = world.get_character_by_id(p.char_index)
	if character:
		character.heading = p.heading
		character.renderer.set_head(p.head)
		character.renderer.set_helmet(p.helmet)
		character.renderer.set_body(p.body)
		character.renderer.set_weapon(p.weapon)
		character.renderer.set_shield(p.shield)
		
	
func handle_npc_swing() -> void:
	ui_controller.add_to_console(Declares.MENSAJE_CRIATURA_FALLA_GOLPE, Color.RED, true, false)

func handle_npc_kill_user() -> void:
	ui_controller.add_to_console(Declares.MENSAJE_CRIATURA_MATADO, Color.RED, true, false)

func handle_npc_hit_user(p:NPCHitUserResponse) -> void:
	const match_dictionary = {
		Declares.bCabeza : Declares.MENSAJE_GOLPE_CABEZA,
		Declares.bBrazoIzquierdo : Declares.MENSAJE_GOLPE_BRAZO_IZQ,
		Declares.bBrazoDerecho : Declares.MENSAJE_GOLPE_BRAZO_DER,
		Declares.bPiernaIzquierda : Declares.MENSAJE_GOLPE_PIERNA_IZQ,
		Declares.bPiernaDerecha : Declares.MENSAJE_GOLPE_PIERNA_DER,
		Declares.bTorso : Declares.MENSAJE_GOLPE_TORSO,
	}
	
	if match_dictionary.has(p.case):
		ui_controller.add_to_console(match_dictionary[p.case] + str(p.damage), Color.RED, true, false)

func handle_change_inventory_slot(p:ChangeInventorySlotResponse) -> void:
	var item = Item.new()
	item.name = p.name
	item.type = p.obj_type
	item.defense = p.defense
	item.grh_id = p.grh_index
	item.id = p.obj_index
	item.max_hit = p.max_hit
	item.min_hit = p.min_hit
	item.price = p.value 
	item.icon = ContentManager.get_texture_from_grh(item.grh_id)
	
	var item_stack = ItemStack.new(item, p.amount, p.equipped)
	player_data.player_inventory.set_item_stack(p.slot - 1, item_stack)
	
func handle_change_npc_inventory_slot(p:ChangeNPCInventorySlotResponse) -> void:
	var item = Item.new()
	item.name = p.name
	item.type = p.obj_type
	item.defense = p.defense
	item.grh_id = p.grh_index
	item.id = p.obj_index
	item.max_hit = p.max_hit
	item.min_hit = p.min_hit
	item.price = p.value 
	item.icon = ContentManager.get_texture_from_grh(item.grh_id)
		
	player_data.npc_inventory.set_item_stack(p.slot - 1, ItemStack.new(item, p.amount, false))

func handle_change_bank_slot(p:ChangeBankSlotResponse) -> void:
	var item = Item.new()
	item.name = p.name
	item.type = p.obj_type
	item.defense = p.defense
	item.grh_id = p.grh_index
	item.id = p.obj_index
	item.max_hit = p.max_hit
	item.min_hit = p.min_hit
	item.price = p.value 
	item.icon = ContentManager.get_texture_from_grh(item.grh_id)
	player_data.bank_inventory.set_item_stack(p.slot -1, ItemStack.new(item, p.amount, false))

	
func handle_change_spell_slot(p:ChangeSpellSlotResponse) -> void:
	player_data.set_spell(p.slot -1, p.id, p.name)

func handle_update_tag_and_status(p:UpdateTagAndStatusResponse) -> void:
	var character = world.get_character_by_id(p.char_index)
	if character:
		character.criminal = p.criminal
		character.set_character_name(p.user_tag)
		character.update_tag_color()

func handle_block_position(p:BlockPositionResponse) -> void:
	world.map.set_tile_blocked(p.x, p.y, p.blocked)
	
func handle_object_create(p:ObjectCreateResponse) -> void:
	world.delete_item(p.x, p.y)
	world.create_item(p.x, p.y, p.grh_id)
	
func handle_object_delete(p:ObjectDeleteResponse) -> void:
	world.delete_item(p.x, p.y)

func handle_change_map(p:ChangeMapResponse) -> void:
	world.load_map(p.id)

func handle_play_midi(p:PlayMIDIResponse) -> void:
	if p.id == 0:
		music_stream_player.stop()
		return
		
	music_stream_player.stream = load("res://assets/musics/%d.mp3" % p.id)
	music_stream_player.play()

func handle_area_change(_p:AreaChangedResponse) -> void:
	pass

func handle_character_create(p:CharacterCreateResponse) -> void:
	world.character_remove(p.char_index)
	world.create_character(p) 
	
func handle_set_invisible(p:SetInvisibleResponse) -> void:
	var character = world.get_character_by_id(p.char_index)
	if character:
		character.visible = !p.invisible
	
func handle_create_fx(p:CreateFXResponse) -> void:
	var character = world.get_character_by_id(p.char_index)
	if character:
		character.character_fx.start_fx(p.fx, p.fx_loops)

func handle_user_char_index_in_server(char_index:int) -> void:
	main_character_index = char_index
	
func handle_update_stats(p:UpdateUserStatsResponse) -> void:
	player_data.experience = p.exp
	player_data.experience_for_next_level = p.elu
	player_data.level = p.elv
	player_data.gold = p.gold
	
	player_data.hp = p.min_hp
	player_data.max_hp = p.max_hp

	player_data.sta = p.min_sta
	player_data.max_sta = p.max_sta

	player_data.mp = p.min_mp
	player_data.max_mp = p.max_mp


func update_hunger_and_thrist(p:UpdateHungerAndThirstResponse) -> void:
	player_data.hunger = p.hunger
	player_data.thirst = p.thirst

func handle_update_exp(experience:int) -> void:
	player_data.experience = experience

func handle_update_mana(mana:int) -> void:
	player_data.mp = mana

func handle_guild_chat(_message:String) -> void:
	pass

func Handle_work_request_target(p:WorkRequestTargetResponse) -> void:
	ui_controller.set_mouse_cursor_shape(Control.CURSOR_MOVE)
	player_data.using_skill = p.using_skill 
	var color = Color8(100, 100, 120)
	match p.using_skill:
		Enums.Skill.MAGIA:
			ui_controller.add_to_console(Declares.MENSAJE_TRABAJO_MAGIA, color, false, false)
		Enums.Skill.PESCA:
			ui_controller.add_to_console(Declares.MENSAJE_TRABAJO_PESCA, color, false, false)
		Enums.Skill.ROBAR:
			ui_controller.add_to_console(Declares.MENSAJE_TRABAJO_ROBAR, color, false, false)
		Enums.Skill.TALAR:
			ui_controller.add_to_console(Declares.MENSAJE_TRABAJO_TALAR, color, false, false)
		Enums.Skill.MINERIA:
			ui_controller.add_to_console(Declares.MENSAJE_TRABAJO_MINERIA, color, false, false)
		Enums.Skill.FUNDIR_METAL:
			ui_controller.add_to_console(Declares.MENSAJE_TRABAJO_FUNDIRMETAL, color, false, false)
		Enums.Skill.PROYECTILES:
			ui_controller.add_to_console(Declares.MENSAJE_TRABAJO_PROYECTILES, color, false, false)


func handle_logged(username:String) -> void:
	player_data.name = username


func handle_navigate_toggle() -> void:
	player_data.user_navegando = !player_data.user_navegando


func handle_bank_init() -> void:
	ui_controller.show_bank_inventory()
	player_data.comerciando = true


func handle_bank_end() -> void:
	ui_controller.hide_bank_inventory()
	player_data.comerciando = false


func handle_commerce_init() -> void:
	ui_controller.show_npc_inventory()
	player_data.comerciando = true


func handle_commerce_end() -> void:
	ui_controller.hide_npc_inventory()
	player_data.comerciando = false


func handle_show_message_box(message:String) -> void:
	if message.to_lower().contains("inactivo"):
		Utils.show_message_box("", message, get_parent())
	else :
		Utils.show_message_box("Server", message, self)	

func handle_send_skills(_p:SendSkillsResponse) -> void:
	pass

func handle_level_up(_skill_points:int) -> void:
	pass

func handle_play_wave(p:PlayWaveResponse) -> void:
	play_sound("%d.wav" % p.id)

func handle_update_hp(hp:int) -> void:
	player_data.hp = hp
	
func handle_pos_update(p:PosUpdateResponse) -> void:
	var character = world.get_character_by_id(main_character_index)
	if !character: return 
	
	character.is_moving = false
	character.grid_position = Vector2i(p.x, p.y)
	character.position = Vector2((p.x - 1) * 32, (p.y - 1) * 32) + Vector2(16, 32)

func handle_character_move(p:CharacterMoveResponse) -> void:
	var sgn = func(value:int) -> int:
		if value == 0: return 0
		if value > 0: return 1
		return -1
	
	var character = world.get_character_by_id(p.char_index)
	if !character: return
	
	var add_x = p.x - character.grid_position.x
	var add_y = p.y - character.grid_position.y
	var heading = Enums.Heading.SOUTH
	
	if sgn.call(add_x) ==  1: heading = Enums.Heading.EAST
	if sgn.call(add_x) == -1: heading = Enums.Heading.WEST
	if sgn.call(add_y) == -1: heading = Enums.Heading.NORTH
	if sgn.call(add_y) ==  1: heading = Enums.Heading.SOUTH
	
	character.grid_position = Vector2i(p.x, p.y)
	character.heading = heading
	character.move_to_heading(heading)
	
	do_pasos_fx(character)

func handle_console_msg(p:ConsoleMsgResponse) -> void:
	var font = Declares.font_types.get(p.font_index)	
	ui_controller.add_to_console(p.message, font.color, font.bold, font.italic)

func handle_user_swing() -> void:
	ui_controller.add_to_console(Declares.MENSAJE_FALLADO_GOLPE, Color.RED, true, false)

func handle_user_hit_npc(damage:int) -> void:
	ui_controller.add_to_console(Declares.MENSAJE_GOLPE_CRIATURA_1 + str(damage) + Declares.MENSAJE_2, Color.RED, true, false)

func handle_message_chat_over_head(p:MessageChatOverHeadResponse) -> void:
	var character = world.get_character_by_id(p.char_index)
	if character:
		var color = Color(p.r / 255.0, p.g / 255.0, p.b / 255.0)
		character.talk(p.message, color)
#endregion
