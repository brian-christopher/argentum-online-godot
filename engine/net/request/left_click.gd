extends RefCounted
class_name LeftClickRequest

var x:int
var y:int

func pack(stream:StreamPeer) -> void: 
	stream.put_u8(Enums.ClientPacketID.LeftClick)
	stream.put_u8(x)
	stream.put_u8(y) 
