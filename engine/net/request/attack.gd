extends RefCounted
class_name AttackRequest


func pack(stream:StreamPeer) -> void: 
	stream.put_u8(Enums.ClientPacketID.Attack)
