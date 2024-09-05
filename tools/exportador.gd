extends Node
	
func add_animation(sprite_frames:SpriteFrames, name:String, grh_id:int):
	sprite_frames.add_animation("idle_" + name);
	sprite_frames.add_animation("walk_" + name);
		
	sprite_frames.set_animation_speed("idle_" + name, 1);
	sprite_frames.set_animation_speed("walk_" + name, 12);	
	
	var grh = ContentManager.grh_data[grh_id]
	for i in range(1, grh.frames_count + 1):
		var frame = ContentManager.grh_data[grh.frames[i]]
		
		if frame.file_num == 0:
			print("animacion %d con file_num invalido" % grh_id)
			return
			
		var atlas_texture = AtlasTexture.new()
		atlas_texture.region = frame.region
		atlas_texture.atlas = ContentManager.get_texture(frame.file_num)
		
		sprite_frames.add_frame("walk_" + name, atlas_texture)
		if i == 1: 
			sprite_frames.add_frame("idle_" + name, atlas_texture)

func add_head_animation(sprite_frames:SpriteFrames, name:String, grh_id:int):
	var grh = ContentManager.grh_data[grh_id]
	var atlas_texture = AtlasTexture.new()
	
	atlas_texture.region = grh.region
	atlas_texture.atlas = ContentManager.get_texture(grh.file_num)
	
	sprite_frames.add_animation(name)
	sprite_frames.add_frame(name, atlas_texture)

func create_tile_map_layer(tiles:PackedInt32Array, tile_set:TileSet) -> TileMapLayer:
	var tile_map_layer = TileMapLayer.new()
	tile_map_layer.tile_set = tile_set
	
	for y in Declares.MAP_HEIGHT:
		for x in Declares.MAP_WIDTH:
			var tile_id = tiles[x + y * Declares.MAP_WIDTH]
			if tile_id == 0:
				continue
			var grh = ContentManager.grh_data[tile_id]
			
			if grh.frames_count > 1:
				grh = ContentManager.grh_data[grh.frames[1]]
				
			if !tile_set.has_source(grh.file_num):
				continue
			
			tile_map_layer.set_cell(Vector2i(x, y), grh.file_num, Vector2i(grh.region.position) / 32)
			
	return tile_map_layer

func create_sprite(x:int, y:int, grh_id:int) -> Sprite2D:
	if grh_id == 0: 
		return null
	
	if ContentManager.grh_data[grh_id].frames_count > 1:
		grh_id = ContentManager.grh_data[grh_id].frames[1]
	var grh = ContentManager.grh_data[grh_id]
	
	if grh.file_num == 0:
		return null
		
	var sprite = Sprite2D.new()
	sprite.region_enabled = true
	sprite.region_rect = grh.region
	sprite.texture = ContentManager.get_texture(grh.file_num)
	sprite.position = Vector2((x * 32) + 16, (y * 32) + 32)
	sprite.offset = Vector2(0, -sprite.region_rect.size.y / 2)
	return sprite

func add_tile_set_atlas_source(tiles:PackedInt32Array, tile_set:TileSet):
	var tile_set_atlas_collection := {} 
	
	for tile_id in tiles:  
		if tile_id == 0: continue
		
		if ContentManager.grh_data[tile_id].frames_count > 1:
			tile_id = ContentManager.grh_data[tile_id].frames[1]
		
		if ContentManager.grh_data[tile_id].file_num == 0:
			continue
		
		var grh = ContentManager.grh_data[tile_id]
		#if grh.region.size != Vector2(32, 32):
		#	print("REGION NO 32X32")
		
		if tile_set.has_source(grh.file_num):
			continue
			
		var texture = load("res://assets/textures/%d.png" % grh.file_num)	 
		var tile_set_atlas_source = TileSetAtlasSource.new()
		tile_set_atlas_source.texture_region_size = Vector2i(32, 32)
		tile_set_atlas_source.texture = texture

		for y in texture.get_height() / 32:
			for x in texture.get_width() / 32: 
				tile_set_atlas_source.create_tile(Vector2i(x, y))
				 
		tile_set.add_source(tile_set_atlas_source, grh.file_num)

func export_weapons() -> void:
	var dats = ConfigFile.new()
	var err = dats.load("res://assets/init/armas.dat")
	if err != OK: return
	
	var count = dats.get_value("INIT", "NumArmas")
	for i in range(1, count + 1):
		if !dats.has_section("ARMA" + str(i)):
			continue
		
		var up    = dats.get_value("ARMA" + str(i), "Dir1", 0);
		var right = dats.get_value("ARMA" + str(i), "Dir2", 0);
		var down  = dats.get_value("ARMA" + str(i), "Dir3", 0);
		var left  = dats.get_value("ARMA" + str(i), "Dir4", 0); 
		
		if(up && right && down && left):
			var sprite_frames = SpriteFrames.new()
			sprite_frames.remove_animation("default")
			
			add_animation(sprite_frames, "right", right)
			add_animation(sprite_frames, "left" , left)
			add_animation(sprite_frames, "up"   , up)
			add_animation(sprite_frames, "down" , down)
			
			ResourceSaver.save(sprite_frames, "res://resources/weapons/weapon_%d.tres" % i)
			
func export_shields() -> void:
	var dats = ConfigFile.new()
	var err = dats.load("res://assets/init/escudos.dat")
	if err != OK: return
	
	var count = dats.get_value("INIT", "NumEscudos")
	for i in range(1, count + 1):
		if !dats.has_section("ESC" + str(i)):
			continue
		
		var up    = dats.get_value("ESC" + str(i), "Dir1", 0);
		var right = dats.get_value("ESC" + str(i), "Dir2", 0);
		var down  = dats.get_value("ESC" + str(i), "Dir3", 0);
		var left  = dats.get_value("ESC" + str(i), "Dir4", 0); 
		
		if(up && right && down && left):
			var sprite_frames = SpriteFrames.new()
			sprite_frames.remove_animation("default")
			
			add_animation(sprite_frames, "right", right)
			add_animation(sprite_frames, "left" , left)
			add_animation(sprite_frames, "up"   , up)
			add_animation(sprite_frames, "down" , down)
			
			ResourceSaver.save(sprite_frames, "res://resources/shields/shield_%d.tres" % i)
	
func export_bodies() -> void:
	var stream = StreamPeerBuffer.new()
	stream.data_array = FileAccess.get_file_as_bytes("res://assets/init/personajes.ind")
	
	#Header
	stream.get_data(255 + 4 + 4) 
	var count = stream.get_16()
	
	for i in range(1, count + 1):
		var up = stream.get_16()
		var right = stream.get_16()
		var down = stream.get_16()
		var left = stream.get_16()
		
		var offset_x = stream.get_16()
		var offset_y = stream.get_16()
		
		if(up && right && down && left):
			var sprite_frames = SpriteFrames.new()
			sprite_frames.set_meta("offset_x", offset_x)
			sprite_frames.set_meta("offset_y", offset_y)
			
			sprite_frames.remove_animation("default")
			
			add_animation.call(sprite_frames, "right", right)
			add_animation.call(sprite_frames, "left" , left)
			add_animation.call(sprite_frames, "up"   , up)
			add_animation.call(sprite_frames, "down" , down)
			
			ResourceSaver.save(sprite_frames, "res://resources/bodies/body_%d.tres" % i)

func export_heads() -> void:
	var stream := StreamPeerBuffer.new()
	stream.data_array = FileAccess.get_file_as_bytes("res://assets/init/cabezas.ind")
	
	#Header
	stream.get_data(4 + 4 + 255)
	
	var count = stream.get_16()
	for i in range(1, count + 1):
		var up    = stream.get_16();
		var right = stream.get_16();
		var down  = stream.get_16();
		var left  = stream.get_16();
		
		if(up && right && down && left):
			var sprite_frames = SpriteFrames.new()
			sprite_frames.remove_animation("default")
			
			add_head_animation(sprite_frames, "idle_right", right)
			add_head_animation(sprite_frames, "idle_left" , left)
			add_head_animation(sprite_frames, "idle_up"   , up)
			add_head_animation(sprite_frames, "idle_down" , down)
			
			ResourceSaver.save(sprite_frames, "res://resources/heads/head_%d.tres" % i)

func export_helmets() -> void:
	var stream := StreamPeerBuffer.new()
	stream.data_array = FileAccess.get_file_as_bytes("res://assets/init/cascos.ind")
	
	#Header
	stream.get_data(4 + 4 + 255)
	
	var count = stream.get_16()
	for i in range(1, count + 1):
		var up    = stream.get_16();
		var right = stream.get_16();
		var down  = stream.get_16();
		var left  = stream.get_16();
		
		if(up && right && down && left):
			var sprite_frames = SpriteFrames.new()
			sprite_frames.remove_animation("default")
			
			add_head_animation(sprite_frames, "idle_right", right)
			add_head_animation(sprite_frames, "idle_left" , left)
			add_head_animation(sprite_frames, "idle_up"   , up)
			add_head_animation(sprite_frames, "idle_down" , down)
			
			ResourceSaver.save(sprite_frames, "res://resources/helmets/helmet_%d.tres" % i)

func export_map(id:int) -> void:
	var map_data = ContentManager.get_map_data(id)  
	var tile_set = TileSet.new()
	tile_set.tile_size = Vector2i(Declares.TILE_SIZE, Declares.TILE_SIZE)
	
	add_tile_set_atlas_source(map_data.layer1, tile_set);
	add_tile_set_atlas_source(map_data.layer2 , tile_set);
	
	var node = Node2D.new()
	var packed_scene = PackedScene.new()
	 
	var layer_1 = create_tile_map_layer(map_data.layer1, tile_set)
	var layer_2 = create_tile_map_layer(map_data.layer2, tile_set)
	var layer_3 = Node2D.new()
	
	node.name = "MapView"
	layer_1.name = "Layer1"
	layer_2.name = "Layer2"
	layer_3.name = "Layer3"
	
	node.add_child(layer_1)
	node.add_child(layer_2)
	node.add_child(layer_3)
	
	layer_1.owner = node
	layer_2.owner = node
	layer_3.owner = node

	layer_3.y_sort_enabled = true
	
	for entity in map_data.layer3:
		var sprite = create_sprite(entity.x, entity.y, entity.grh_id) 
		if sprite:
			layer_3.add_child(sprite) 
			sprite.owner = node
	
	node.set_meta("data", map_data.flags)
	if packed_scene.pack(node) == OK:
		ResourceSaver.save(packed_scene, "res://maps/map_%d.tscn" % id)

func export_maps() -> void:
	for i in range(1, 282 + 1):
		export_map(i)

func export_fxs() -> void:
	var stream = StreamPeerBuffer.new()
	stream.data_array = FileAccess.get_file_as_bytes("res://assets/init/fxs.ind")
	stream.get_data(255 + 4 + 4)
	
	var count = stream.get_16()
	for i in range(1, count + 1):
		var grh_id = stream.get_16()
		var offset_x = stream.get_16()
		var offset_y = stream.get_16()
		
		var sprite_frames = SpriteFrames.new()
		sprite_frames.set_meta("offset_x", offset_x)
		sprite_frames.set_meta("offset_y", offset_y)
		sprite_frames.set_animation_loop("default", false)
		sprite_frames.set_animation_speed("default", 12);	
		
		var grh = ContentManager.grh_data[grh_id]
		for frame_id in range(1, grh.frames_count + 1):
			var frame = ContentManager.grh_data[grh.frames[frame_id]]
			
			var atlas_texture = AtlasTexture.new()
			atlas_texture.atlas = ContentManager.get_texture(frame.file_num)
			atlas_texture.region = frame.region
			sprite_frames.add_frame("default", atlas_texture) 
			
		ResourceSaver.save(sprite_frames, "res://resources/fxs/fx_%d.tres" % i)
	
