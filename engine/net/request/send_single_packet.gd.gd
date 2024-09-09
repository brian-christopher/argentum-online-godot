extends RefCounted
class_name SendSinglePacketRequest

var packet_id:int

func _init(p_packet_id:int) -> void:
    packet_id = p_packet_id


func pack(stream:StreamPeer) -> void: 
    stream.put_u8(packet_id)
