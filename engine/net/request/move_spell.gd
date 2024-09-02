extends RefCounted
class_name MoveSpellRequest

var upwards:bool
var slot:int

func _init(p_upwards:bool = false, p_slot:int = 0) -> void:
	upwards = p_upwards
	slot = p_slot

func pack(stream:StreamPeer) -> void: 
	stream.put_u8(Enums.ClientPacketID.MoveSpell)
	stream.put_u8(upwards)
	stream.put_u8(slot)
