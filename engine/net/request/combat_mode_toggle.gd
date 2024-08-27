extends RefCounted	
class_name CombatModeToggleRequest

func pack(stream:StreamPeer) -> void: 
	stream.put_u8(Enums.ClientPacketID.CombatModeToggle)
