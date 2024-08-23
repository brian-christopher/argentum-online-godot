extends RefCounted
class_name ChangeSpellSlotResponse

var slot:int
var id:int
var name:String


static func unpack(stream:StreamPeer) -> ChangeSpellSlotResponse:
	var p = ChangeSpellSlotResponse.new()
	p.slot = stream.get_u8()
	p.id = stream.get_16()
	p.name = stream.get_utf8_string()
	
	return p
