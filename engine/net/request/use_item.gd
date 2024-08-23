extends RefCounted
class_name UseItemRequest
 
var slot:int

func pack(stream:StreamPeer) -> void: 
	stream.put_u8(Enums.ClientPacketID.UseItem)
	stream.put_u8(slot)
