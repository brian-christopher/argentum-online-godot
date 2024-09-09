extends RefCounted
class_name DenounceRequest

var message:String

func _init(p_message:String = "") -> void:
	message = p_message


func pack(stream:StreamPeer) -> void: 
	stream.put_u8(Enums.ClientPacketID.Denounce)
	stream.put_utf8_string(message)
