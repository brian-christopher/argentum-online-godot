extends Node
class_name PlayMIDIResponse

var id:int
var loop:int

static func unpack(stream:StreamPeer) -> PlayMIDIResponse:
	var p = PlayMIDIResponse.new()
	p.id = stream.get_u8()
	p.loop = stream.get_16() 
	
	return p
