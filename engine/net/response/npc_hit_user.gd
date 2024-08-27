extends RefCounted
class_name NPCHitUserResponse

var case:int
var damage:int

static func unpack(stream:StreamPeer) -> NPCHitUserResponse:
	var p = NPCHitUserResponse.new() 
	p.case = stream.get_u8()
	p.damage = stream.get_16() 
	return p
