extends RefCounted
class_name PickUpRequest


func pack(stream:StreamPeer) -> void: 
	stream.put_u8(Enums.ClientPacketID.PickUp)
