extends RefCounted
class_name ChangeMapResponse

var id:int
var version:int

static func unpack(stream:StreamPeer) -> ChangeMapResponse:
	var p = ChangeMapResponse.new() 
	p.id = stream.get_16()
	p.version = stream.get_16() 
	return p
