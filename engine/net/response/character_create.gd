extends RefCounted
class_name CharacterCreateResponse

var char_index:int
var name:String

var heading:int
var x:int
var y:int

var criminal:int
var privileges:int

var head:int
var helmet:int
var body:int
var weapon:int
var shield:int

var fx:int
var fx_loop:int

static func unpack(stream:StreamPeer) -> CharacterCreateResponse:
	var p = CharacterCreateResponse.new() 
	p.char_index = stream.get_16() 
	p.body = stream.get_16()
	p.head = stream.get_16()
	
	p.heading = stream.get_u8()
	p.x = stream.get_u8()
	p.y = stream.get_u8()
	
	p.weapon = stream.get_16()
	p.shield = stream.get_16()
	p.helmet = stream.get_16()
	
	p.fx = stream.get_16()
	p.fx_loop = stream.get_16()
	
	p.name = stream.get_utf8_string()
	p.criminal = stream.get_u8()
	p.privileges = stream.get_u8() 
	return p
