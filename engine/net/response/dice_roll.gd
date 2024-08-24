extends RefCounted
class_name DiceRollResponse

var attributes:PackedByteArray

func _init() -> void:
	attributes.resize(Declares.NUMATRIBUTES)

static func unpack(stream:StreamPeer) -> DiceRollResponse:
	var p = DiceRollResponse.new()  
	
	for i in Declares.NUMATRIBUTES:
		p.attributes[i] = stream.get_u8() 
	return p
