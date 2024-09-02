extends RefCounted
class_name SpellInfoRequest

var slot:int

func pack(stream:StreamPeer) -> void: 
	stream.put_u8(Enums.ClientPacketID.SpellInfo)
	stream.put_u8(slot)
