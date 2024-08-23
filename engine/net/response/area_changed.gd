extends RefCounted
class_name AreaChangedResponse
 
var x:int
var y:int

static func unpack(stream:StreamPeer) -> AreaChangedResponse:
	var p = AreaChangedResponse.new() 
	p.x = stream.get_u8()
	p.y = stream.get_u8()
	
	return p
