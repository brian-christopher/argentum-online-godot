extends RefCounted
class_name CharacterChangeResponse

var char_index:int
var body:int
var head:int
var heading:int
var weapon:int
var shield:int
var helmet:int
var fx_id:int
var fx_loops:int

static func unpack(stream:StreamPeer) -> CharacterChangeResponse:
	var p = CharacterChangeResponse.new()  
	p.char_index = stream.get_16()
	p.body = stream.get_16()
	p.head = stream.get_16()
	p.heading = stream.get_u8()
	p.weapon = stream.get_16()
	p.shield = stream.get_16()
	p.helmet = stream.get_16()
	p.fx_id = stream.get_16()
	p.fx_loops = stream.get_16()
	return p
