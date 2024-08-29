extends RefCounted
class_name SetInvisibleResponse

var char_index:int
var invisible:bool

static func unpack(stream:StreamPeer) -> SetInvisibleResponse:
	var p = SetInvisibleResponse.new() 
	p.char_index = stream.get_16()
	p.invisible = stream.get_u8()
	
	return p
