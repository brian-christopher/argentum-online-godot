extends Node
class_name ThrowDicesRequest
 
func pack(stream:StreamPeer) -> void: 
	stream.put_u8(Enums.ClientPacketID.ThrowDices) 
