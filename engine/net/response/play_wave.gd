extends RefCounted
class_name PlayWaveResponse

var x:int
var y:int
var id:int

static func unpack(stream:StreamPeer) -> PlayWaveResponse:
	var p = PlayWaveResponse.new()
	p.id = stream.get_u8() 
	p.x = stream.get_u8()
	p.y = stream.get_u8()
	
	return p
