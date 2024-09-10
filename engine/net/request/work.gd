extends RefCounted
class_name WorldRequest

var skill:int

func _init(p_skill:int = 0) -> void:
	skill = p_skill;

func pack(stream:StreamPeer) -> void: 
	stream.put_u8(Enums.ClientPacketID.Work)
	stream.put_u8(skill)
