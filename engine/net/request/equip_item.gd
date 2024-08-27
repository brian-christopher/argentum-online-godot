extends RefCounted
class_name EquipItemRequest

var slot:int 

func pack(stream:StreamPeer) -> void: 
	stream.put_u8(Enums.ClientPacketID.EquipItem)
	stream.put_u8(slot) 
