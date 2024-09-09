extends RefCounted
class_name ChangeDescriptionRequest

var description:String

func _init(p_description:String = "") -> void:
	description = p_description


func pack(stream:StreamPeer) -> void: 
	stream.put_u8(Enums.ClientPacketID.ChangeDescription)
	stream.put_utf8_string(description)
