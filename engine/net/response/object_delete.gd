extends RefCounted
class_name ObjectDeleteResponse

var x:int
var y:int

static func unpack(stream:StreamPeer) -> ObjectDeleteResponse:
	var p = ObjectDeleteResponse.new()   
	p.x = stream.get_u8()
	p.y = stream.get_u8() 
	return p
