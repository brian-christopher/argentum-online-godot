extends Node
class_name MessageChatOverHeadResponse

var message:String
var char_index:int

var r:int
var g:int
var b:int

static func unpack(stream:StreamPeer) -> MessageChatOverHeadResponse:
	var p = MessageChatOverHeadResponse.new()  
	p.message = stream.get_utf8_string()
	p.char_index = stream.get_16() 
	
	p.r = stream.get_u8() 
	p.g = stream.get_u8() 
	p.b = stream.get_u8()  
	return p
