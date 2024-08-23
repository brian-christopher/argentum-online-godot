extends RefCounted
class_name CreateFXResponse

var char_index:int
var fx:int
var fx_loops:int

static func unpack(stream:StreamPeer) -> CreateFXResponse:
	var p = CreateFXResponse.new()  
	p.char_index = stream.get_16()
	p.fx = stream.get_16()
	p.fx_loops = stream.get_16() 
	return p
