extends RefCounted
class_name CastSpellRequest

var slot:int 

func pack(stream:StreamPeer) -> void: 
	stream.put_u8(Enums.ClientPacketID.CastSpell)
	stream.put_u8(slot)
