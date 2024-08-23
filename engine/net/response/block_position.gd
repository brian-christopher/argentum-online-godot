extends RefCounted
class_name BlockPositionResponse

var x:int
var y:int
var blocked:bool

static func unpack(stream:StreamPeer) -> BlockPositionResponse:
	var p = BlockPositionResponse.new() 
	p.x = stream.get_u8()
	p.y = stream.get_u8()
	p.blocked = stream.get_u8()  
	return p
