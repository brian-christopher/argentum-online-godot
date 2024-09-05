extends RefCounted
class_name WorkRequestTargetResponse

var using_skill:int

static func unpack(stream:StreamPeer) -> WorkRequestTargetResponse:
	var p = WorkRequestTargetResponse.new()
	p.using_skill = stream.get_u8()  
	return p
