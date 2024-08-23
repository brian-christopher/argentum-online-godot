extends RefCounted
class_name ObjectCreateResponse

var x:int
var y:int
var grh_id:int

static func unpack(stream:StreamPeer) -> ObjectCreateResponse:
	var p = ObjectCreateResponse.new() 
	p.x = stream.get_u8()
	p.y = stream.get_u8()
	p.grh_id = stream.get_16()
	return p
