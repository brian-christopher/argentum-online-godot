extends RefCounted
class_name ChangeHeadingRequest

var heading:int 

func pack(stream:StreamPeer) -> void: 
	stream.put_u8(Enums.ClientPacketID.ChangeHeading)
	stream.put_u8(heading)
