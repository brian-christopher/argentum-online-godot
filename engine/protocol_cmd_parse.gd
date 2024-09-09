extends RefCounted
class_name Commands

class CommandArgs:
    var player_data: PlayerData
    var ui_controller: UIController
    var parameters: PackedStringArray


static var _commands: Dictionary

static func _static_init() -> void:
    add_command("online", _command_online)
    add_command("salir", _command_quit)
    add_command("balance", _command_request_account_state)
    add_command("seg", _command_safe_toggle)
    add_command("meditar", _command_meditate)
    add_command("retirar", _command_bank_extract_gold)
    add_command("depositar", _command_bank_deposit_gold)
    add_command("est", _command_request_stats)
    add_command("enlistar", _command_enlist)
    add_command("informacion", _command_information)
    add_command("recompensa", _command_reward)
    add_command("denunciar", _command_denounce)
    add_command("desc", _command_change_description)
    add_command("gm", _command_gm_request)

static func add_command(command_name: String, command_handler: Callable) -> void:
    _commands[command_name] = command_handler


static func parse_user_command(raw_command: String, player_data: PlayerData, ui_controller: UIController) -> void:
    if raw_command.is_empty():
        return
 
    var args := raw_command.substr(1).strip_edges(false, true).split(" ")
    
    if raw_command.begins_with("/"):
        var command := args[0].to_lower()
        var command_args := CommandArgs.new()

        command_args.player_data = player_data
        command_args.ui_controller = ui_controller
        command_args.parameters = args.slice(1)

        if _commands.has(command):
            _commands[command].call(command_args)
            
    elif raw_command.begins_with("\\"):
        pass
    elif raw_command.begins_with("-"):
        pass
    else:
        SessionManager.send_packet(TalkRequest.new(raw_command.substr(1)))


static func _command_online(_p: CommandArgs) -> void:
    SessionManager.send_packet(SendSinglePacketRequest \
        .new(Enums.ClientPacketID.Online))


static func _command_quit(args: CommandArgs) -> void:
    if args.player_data.user_paralizado:
        args.ui_controller.add_to_console("No puedes salir estando paralizado", Color.GRAY)
        return

    SessionManager.send_packet(SendSinglePacketRequest \
        .new(Enums.ClientPacketID.Quit))


static func _command_request_account_state(_p: CommandArgs) -> void:
    SessionManager.send_packet(SendSinglePacketRequest \
        .new(Enums.ClientPacketID.RequestAccountState))


static func _command_safe_toggle(_args: CommandArgs) -> void:
    SessionManager.send_packet(SendSinglePacketRequest \
        .new(Enums.ClientPacketID.SafeToggle))


static func _command_meditate(args: CommandArgs) -> void:
    if args.player_data.mp == 0:
        return

    if not args.player_data.is_alive:
        args.ui_controller.add_to_console("¡¡Estás muerto!!", Color.GRAY)
        return
    SessionManager.send_packet(MeditateRequest.new())


static func _command_bank_extract_gold(args: CommandArgs) -> void:
    if not args.player_data.is_alive:
        args.ui_controller.add_to_console("¡¡Estás muerto!!", Color.GRAY)
        return
    
    if args.parameters.is_empty():
        SessionManager.send_packet(SendSinglePacketRequest \
            .new(Enums.ClientPacketID.LeaveFaction))
    else:
        if not args.parameters[0].is_valid_int():
            args.ui_controller.add_to_console("Cantidad incorrecta. Utilice /retirar CANTIDAD.", Color.GRAY)
        else:
            var quantity := args.parameters[0].to_int()
            SessionManager.send_packet(BankExtractGoldRequest.new(quantity))


static func _command_bank_deposit_gold(args: CommandArgs) -> void:
    if not args.player_data.is_alive:
        args.ui_controller.add_to_console("¡¡Estás muerto!!", Color.GRAY)
        return
    
    if args.parameters.is_empty() or not args.parameters[0].is_valid_int():
        args.ui_controller.add_to_console("Cantidad incorrecta. Utilice /depositar CANTIDAD.", Color.GRAY)
    else: 
        var quantity := args.parameters[0].to_int()
        SessionManager.send_packet(BankDepositGoldRequest.new(quantity))


static func _command_request_stats(_args: CommandArgs) -> void:
    SessionManager.send_packet(SendSinglePacketRequest \
        .new(Enums.ClientPacketID.RequestStats))     


static func _command_enlist(_args: CommandArgs) -> void:
    SessionManager.send_packet(SendSinglePacketRequest \
        .new(Enums.ClientPacketID.Enlist))     

static func _command_information(_args: CommandArgs) -> void:
    SessionManager.send_packet(SendSinglePacketRequest \
        .new(Enums.ClientPacketID.Information))     


static func _command_reward(_args: CommandArgs) -> void:
    SessionManager.send_packet(SendSinglePacketRequest \
        .new(Enums.ClientPacketID.Reward))     


static func _command_denounce(args: CommandArgs) -> void:
    if args.parameters.is_empty():
        args.ui_controller.add_to_console("Formule su denuncia.", Color.GRAY)
    else:
        SessionManager.send_packet(DenounceRequest \
            .new(args.parameters[0]))  
    

static func _command_change_description(args: CommandArgs) -> void:
    if not args.player_data.is_alive:
        args.ui_controller.add_to_console("¡¡Estás muerto!!", Color.GRAY)
    else:
        var description := "" 
        if not args.parameters.is_empty():
            description = args.parameters[0]

        SessionManager.send_packet(ChangeDescriptionRequest \
            .new(description))


static func _command_gm_request(_args: CommandArgs) -> void:
    SessionManager.send_packet(SendSinglePacketRequest \
        .new(Enums.ClientPacketID.GMRequest))    