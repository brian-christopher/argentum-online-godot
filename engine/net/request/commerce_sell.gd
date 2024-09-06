extends RefCounted
class_name CommerceSellRequest

var slot:int
var amount:int

func _init(p_slot:int = 0, p_amount:int = 0) -> void:
	slot = p_slot
	amount = p_amount

func pack(stream:StreamPeer) -> void: 
	stream.put_u8(Enums.ClientPacketID.CommerceSell)
	stream.put_u8(slot)
	stream.put_16(amount) 