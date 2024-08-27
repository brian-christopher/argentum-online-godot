extends Node2D
class_name Map

var map_view:Node2D
var map_data:PackedByteArray

func _ready() -> void:
	map_data.resize(Declares.MAP_WIDTH * Declares.MAP_HEIGHT)
	map_data.fill(Enums.TileFlags.BLOCKED)

func load_map(id:int) -> void:
	if map_view:
		map_view.queue_free()
	map_view = load("res://maps/map_%d.tscn" % id).instantiate()
	map_data = map_view.get_meta("data")
	
	add_child(map_view)

func add_overlap_entity(node:Node) -> void:
	if map_view:
		map_view.get_node("Layer3").add_child(node)
		
func is_tile_blocked(x:int, y:int, fixed:bool = true) -> bool: 
	if fixed:
		x -= 1
		y -= 1 
	return map_data[x + y * Declares.MAP_WIDTH] & Enums.TileFlags.BLOCKED

func set_tile_blocked(x:int, y:int, state:bool, fixed:bool = true) -> void: 
	if fixed:
		x -= 1
		y -= 1 
		
	var flags = map_data[x + y * Declares.MAP_WIDTH]	
	if state:
		flags |= Enums.TileFlags.BLOCKED
	else:
		flags &= ~Enums.TileFlags.BLOCKED
	map_data[x + y * Declares.MAP_WIDTH] = flags
