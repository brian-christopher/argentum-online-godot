extends RefCounted
class_name UpdateTagAndStatusResponse

var char_index:int
var criminal:bool
var user_tag:String

static func unpack(stream:StreamPeer) -> UpdateTagAndStatusResponse:
	var p = UpdateTagAndStatusResponse.new()
	p.char_index = stream.get_16()  
	p.criminal = stream.get_u8()  
	p.user_tag = stream.get_utf8_string()  
	return p
