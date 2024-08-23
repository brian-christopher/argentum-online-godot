extends Node
class_name CharacterMoveResponse

var char_index:int
var x:int
var y:int

static func unpack(stream:StreamPeer) -> CharacterMoveResponse:
	var p = CharacterMoveResponse.new()  
	p.char_index = stream.get_16()
	p.x = stream.get_u8()
	p.y = stream.get_u8() 
	return p
