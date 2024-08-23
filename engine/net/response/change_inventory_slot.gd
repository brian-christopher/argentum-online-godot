extends RefCounted
class_name ChangeInventorySlotResponse

var slot:int
var name:String
var obj_index
var amount:int
var equipped:bool
var grh_index:int
var obj_type:int
var max_hit:int
var min_hit:int
var defense:int
var value:int

static func unpack(stream:StreamPeer) -> ChangeInventorySlotResponse:
	var p = ChangeInventorySlotResponse.new()
	p.slot = stream.get_u8()
	p.obj_index = stream.get_16()
	p.name = stream.get_utf8_string()
	p.amount = stream.get_16()
	p.equipped = stream.get_u8()
	p.grh_index = stream.get_16()
	p.obj_type = stream.get_u8()
	
	p.max_hit = stream.get_16()
	p.min_hit = stream.get_16()
	
	p.defense = stream.get_16()
	p.value = stream.get_float()
	
	return p
