extends RefCounted
class_name BankEndRequest

func pack(stream:StreamPeer) -> void: 
	stream.put_u8(Enums.ClientPacketID.BankEnd)
