extends Node
class_name UpdateHungerAndThirstResponse

var thirst:int
var hunger:int

static func unpack(stream: StreamPeerBuffer) -> UpdateHungerAndThirstResponse:
	var p = UpdateHungerAndThirstResponse.new() 
	stream.get_u8()
	p.thirst = stream.get_u8()
	
	stream.get_u8()
	p.hunger =stream.get_u8() 
	return p
