extends RefCounted
class_name WorldRequest

var skill:int

func pack(stream:StreamPeer) -> void: 
	stream.put_u8(Enums.ClientPacketID.Work)
	stream.put_u8(skill)
