extends RefCounted
class_name MeditateRequest

func pack(stream:StreamPeer) -> void: 
	stream.put_u8(Enums.ClientPacketID.Meditate)
