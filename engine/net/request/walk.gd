extends RefCounted
class_name WalkRequest
 
var heading:int

func pack(stream:StreamPeer) -> void: 
	stream.put_u8(Enums.ClientPacketID.Walk)
	stream.put_u8(heading)
