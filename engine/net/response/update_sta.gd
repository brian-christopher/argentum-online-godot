extends RefCounted
class_name UpdateStaResponse

var min_sta:int

static func unpack(stream:StreamPeer) -> UpdateStaResponse:
	var p = UpdateStaResponse.new()
	p.min_sta = stream.get_u8()  
	return p
