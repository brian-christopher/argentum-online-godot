extends RefCounted
class_name PlayerData

signal property_changed(property_name:String)
signal spell_changed(slot:int, id:int, name:String)


var inventory:Inventory
var npc_inventory:Inventory

var comerciando:bool
var user_navegando:bool
var using_skill:int 
var spells:Array[SpellData]

func _init() -> void:
	inventory = Inventory.new(Declares.MAX_INVENTORY_SLOTS)
	npc_inventory = Inventory.new(Declares.MAX_NPC_INVENTORY_SLOTS)
	
	spells.resize(Declares.MAXHECHI)
	spells.fill(SpellData.new(0, "(None)"))
	
var gold:int:
	get:
		return gold
	set(value):
		gold = value
		property_changed.emit("gold")

var level:int:
	get:
		return level
	set(value):
		level = value
		property_changed.emit("level")
		
var hp:int:
	get:
		return hp
	set(value):
		hp = value
		property_changed.emit("hp")
		
var max_hp:int:
	get:
		return max_hp
	set(value):
		max_hp = value
		property_changed.emit("max_hp")	
		
var sta:int:
	get:
		return sta
	set(value):
		sta = value
		property_changed.emit("sta")
		
var max_sta:int:
	get:
		return max_sta
	set(value):
		max_sta = value
		property_changed.emit("max_sta")	
		
var mp:int:
	get:
		return mp
	set(value):
		mp = value
		property_changed.emit("mp")
		
var max_mp:int:
	get:
		return max_mp
	set(value):
		max_mp = value
		property_changed.emit("max_mp")

var experience:int:
	get:
		return experience
	set(value):
		experience = value
		property_changed.emit("experience")

var experience_for_next_level:int:
	get:
		return experience_for_next_level
	set(value):
		experience_for_next_level = value
		property_changed.emit("experience_for_next_level")

var name:String:
	get:
		return name
	set(value):
		name = value
		property_changed.emit("name")
		
var thirst:int:
	get:
		return thirst
	set(value):
		thirst = value
		property_changed.emit("thirst")

var hunger:int:
	get:
		return hunger
	set(value):
		hunger = value
		property_changed.emit("hunger")

func set_spell(slot:int, spell_id:int, spell_name:String) -> void:
	spells[slot] = SpellData.new(spell_id, spell_name)
	spell_changed.emit(slot, spell_id, spell_name)
