extends RefCounted
class_name ConsoleMsgResponse

var message:String
var font_index:int

static func unpack(stream:StreamPeer) -> ConsoleMsgResponse:
	var p = ConsoleMsgResponse.new()  
	p.message = stream.get_utf8_string()
	p.font_index = stream.get_u8() 
	return p
