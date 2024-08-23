extends RefCounted
class_name PosUpdateResponse

var x:int
var y:int

static func unpack(stream: StreamPeerBuffer) -> PosUpdateResponse:
	var p = PosUpdateResponse.new()
	
	p.x = stream.get_u8() 
	p.y = stream.get_u8()  
	return p
