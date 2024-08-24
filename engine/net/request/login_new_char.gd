extends RefCounted
class_name LoginNewCharRequest

var username:String
var password:String
var email:String

var user_race:int
var user_gender:int
var user_class:int
var user_home:int

var app_major:int = 0
var app_minor:int = 12
var app_revision:int = 1

func pack(stream:StreamPeer) -> void: 
	stream.put_u8(Enums.ClientPacketID.LoginNewChar)
	stream.put_utf8_string(username)
	stream.put_utf8_string(password)
	
	stream.put_u8(app_major)
	stream.put_u8(app_minor)
	stream.put_u8(app_revision)

	for i in 7: stream.put_16(0)
	
	stream.put_u8(user_race)
	stream.put_u8(user_gender)
	stream.put_u8(user_class)
	
	stream.put_utf8_string(email)
	stream.put_u8(user_home)
