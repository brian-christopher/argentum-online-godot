extends RefCounted
class_name SendSkillsResponse

var skills:PackedInt32Array

func _init() -> void:
	skills.resize(Declares.NUMSKILLS)


static func unpack(stream:StreamPeer) -> SendSkillsResponse:
	var p = SendSkillsResponse.new() 
	
	for i in Declares.NUMSKILLS:
		p.skills[i] = stream.get_u8()
	return p
