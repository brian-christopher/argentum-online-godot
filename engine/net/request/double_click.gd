extends Node
class_name DoubleClickRequest

var x:int
var y:int

func pack(stream:StreamPeer) -> void: 
	stream.put_u8(Enums.ClientPacketID.DoubleClick)
	stream.put_u8(x)
	stream.put_u8(y) 
