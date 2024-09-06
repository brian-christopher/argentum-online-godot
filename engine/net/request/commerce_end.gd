extends RefCounted
class_name CommerceEndRequest

func pack(stream:StreamPeer) -> void: 
	stream.put_u8(Enums.ClientPacketID.CommerceEnd)
