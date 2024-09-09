extends RefCounted
class_name BankDepositGoldRequest

var quantity:int

func _init(p_quantity:int = 0) -> void:
    quantity = p_quantity

func pack(stream:StreamPeer) -> void:
    stream.put_u8(Enums.ClientPacketID.BankDepositGold)
    stream.put_32(quantity)