extends Node

class GrhData:
	var file_num:int
	var frames:Array[int]
	var frames_count:int
	
	var region:Rect2
	var speed:float
	
class MapObject:
	var x:int
	var y:int
	var grh_id:int
	
	func _init(x:int, y:int, grh_id:int) -> void:
		self.x = x
		self.y = y
		self.grh_id = grh_id
	
class MapData:
	var layer1:PackedInt32Array
	var layer2:PackedInt32Array
	var flags:PackedByteArray
	
	var layer3:Array[MapObject]
	var layer4:Array[MapObject]
	
	func _init() -> void:
		layer1.resize(Declares.MAP_WIDTH * Declares.MAP_HEIGHT)
		layer2.resize(Declares.MAP_WIDTH * Declares.MAP_HEIGHT)
		layer2.fill(0)
		
		flags.resize(Declares.MAP_WIDTH * Declares.MAP_HEIGHT)
		flags.fill(0)
	 
var grh_data:Array[GrhData]
var colores_pj:Array[Color]

func _ready() -> void:
	load_grh_data() 
	load_colors()

func load_grh_data() -> void:
	var bytes = FileAccess.get_file_as_bytes("res://assets/init/graficos.ind")
	var stream = StreamPeerBuffer.new()
	stream.data_array = bytes
	
	var size = stream.get_32()
	var grh_count = stream.get_32()
	
	grh_data.resize(grh_count + 1)
	for i in grh_data.size():
		grh_data[i] = GrhData.new()
		
	while stream.get_position() < stream.get_size():
		var grh_id = stream.get_32()
		var grh = GrhData.new()
		
		grh.frames_count = stream.get_16()
		grh.frames.resize(grh.frames_count + 1)
		grh.frames.fill(0)
		
		if grh.frames_count > 1:
			for i in grh.frames_count:
				grh.frames[i + 1] = stream.get_32()
				
			grh.speed = stream.get_float()
			grh.region = grh_data[grh.frames[1]].region
		else:
			grh.file_num = stream.get_32()
			grh.frames[1] = grh_id
			
			grh.region.position.x = stream.get_16()
			grh.region.position.y = stream.get_16()
			grh.region.size.x = stream.get_16()
			grh.region.size.y = stream.get_16()
		
		grh_data[grh_id] = grh
		
func load_colors() -> void:
	var data = ConfigFile.new()
	data.load("res://assets/init/colores.dat")
	colores_pj.resize(51)
	colores_pj.fill(Color.WHITE)
	
	for i in 51:
		var color = Color8(data.get_value(str(i) , "R", 0), \
							data.get_value(str(i), "G", 0), \
							data.get_value(str(i), "B", 0))
		colores_pj[i] = color
		
	colores_pj[49] =  Color8(data.get_value("Ci", "R", 0), \
							 data.get_value("Ci", "G", 0), \
							 data.get_value("Ci", "B", 0))
							
	colores_pj[50] =  Color8(data.get_value("Cr", "R", 0), \
							 data.get_value("Cr", "G", 0), \
							 data.get_value("Cr", "B", 0))

func get_texture(id:int) -> Texture2D:
	if id == 0: return null  
	return load("res://assets/textures/%d.png" % id)

func get_texture_from_grh(grh_id:int) -> Texture2D:
	return get_texture(grh_data[grh_id].file_num)

func get_map_data(id:int) -> MapData:
	var map_data = MapData.new()
	
	var stream = StreamPeerBuffer.new() 
	stream.data_array = FileAccess.get_file_as_bytes("res://assets/maps/mapa%d.map" % id)
	
	# Header
	stream.seek(2 + 255 + 4 + 4 + 8)
	
	for y in Declares.MAP_HEIGHT:
		for x in Declares.MAP_WIDTH:
			var index = x + y * Declares.MAP_WIDTH
			var flags = stream.get_u8()
			
			map_data.layer1[index] = stream.get_16()
			
			if flags & 0x1:
				map_data.flags[index] |= Enums.TileFlags.BLOCKED
			
			if flags & 0x2:
				map_data.layer2[index] = stream.get_16()
				
			if flags & 0x4:
				map_data.layer3.push_back(MapObject.new(x, y, stream.get_16()))
				
			if flags & 0x8:
				map_data.layer4.push_back(MapObject.new(x, y, stream.get_16()))
				
			if flags & 0x10:
				var trigger = stream.get_16() 
				if trigger == 1 || trigger == 2 || trigger == 4:
					map_data.flags[index] |= Enums.TileFlags.ROOF
					pass
				
			if ((map_data.layer1[index] >= 1505 && map_data.layer1[index] <= 1520) || \
				(map_data.layer1[index] >= 5665 && map_data.layer1[index] <= 5680) || \
				(map_data.layer1[index] >= 13547 && map_data.layer1[index] <= 13562)) && map_data.layer2[index] == 0:
					map_data.flags[index] |= Enums.TileFlags.WATER
					 
	return map_data
