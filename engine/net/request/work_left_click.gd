extends RefCounted
class_name WorkLeftClickRequest

var skill:int
var x:int
var y:int

func _init(p_x:int = 0, p_y:int = 0, p_skill:int = 0) -> void:
	x = p_x
	y = p_y
	skill = p_skill

func pack(stream:StreamPeer) -> void: 
	stream.put_u8(Enums.ClientPacketID.WorkLeftClick)
	stream.put_u8(x) 
	stream.put_u8(y)
	stream.put_u8(skill)
