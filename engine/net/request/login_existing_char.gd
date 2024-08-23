extends RefCounted
class_name LoginExistingCharRequest

var username:String
var password:String

var app_major:int = 0
var app_minor:int = 12
var app_revision:int = 1

func pack(stream:StreamPeer) -> void: 
	stream.put_u8(Enums.ClientPacketID.LoginExistingChar)
	stream.put_utf8_string(username)
	stream.put_utf8_string(password)
	
	stream.put_u8(app_major)
	stream.put_u8(app_minor)
	stream.put_u8(app_revision)
	
	for i in 7:
		stream.put_16(0)
