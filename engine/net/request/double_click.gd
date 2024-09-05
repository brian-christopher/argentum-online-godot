extends Node
class_name DoubleClickRequest

var x:int
var y:int

func _init(p_x:int = 0, p_y:int = 0) -> void:
	x = p_x
	y = p_y

func pack(stream:StreamPeer) -> void: 
	stream.put_u8(Enums.ClientPacketID.DoubleClick)
	stream.put_u8(x)
	stream.put_u8(y) 
