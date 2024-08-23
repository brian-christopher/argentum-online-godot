extends RefCounted
class_name UpdateUserStatsResponse

var max_hp: int
var min_hp: int

var max_mp: int
var min_mp: int

var max_sta: int
var min_sta: int

var gold: int
var elv: int
var elu: int
var exp: int


static func unpack(stream: StreamPeerBuffer) -> UpdateUserStatsResponse:
	var p = UpdateUserStatsResponse.new()
	
	p.max_hp = stream.get_16()
	p.min_hp = stream.get_16()
	
	p.max_mp = stream.get_16()
	p.min_mp = stream.get_16()
	
	p.max_sta = stream.get_16()
	p.min_sta = stream.get_16()
	
	p.gold = stream.get_32()
	p.elv = stream.get_u8()
	
	p.elu = stream.get_32()
	p.exp = stream.get_32()

	return p
