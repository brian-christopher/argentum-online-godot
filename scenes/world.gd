extends Node2D
class_name World

@export var character_scene:PackedScene
@export var map:Map

var characters:Array[CharacterController]
var items:Dictionary

func load_map(id:int) -> void:
	characters.clear()
	items.clear()
	map.load_map(id)

func create_character(data:CharacterCreateResponse) -> void:
	var character = character_scene.instantiate() as CharacterController
	characters.push_back(character)
	map.add_overlap_entity(character)
	
	character.set_character_name(data.name)
	character.char_index = data.char_index
	character.heading = data.heading
	character.speed = 110 if data.name.is_empty() else 140
	character.renderer.set_helmet(data.helmet)
	character.renderer.set_head(data.head)
	character.renderer.set_body(data.body)
	character.renderer.set_shield(data.shield)
	character.renderer.set_weapon(data.weapon)
	character.grid_position = Vector2i(data.x, data.y)
	character.position = Vector2((data.x - 1) * 32, (data.y - 1) * 32) + Vector2(16, 32)
	
func character_remove(char_index:int) -> void:
	var character = get_character_by_id(char_index)
	if character:
		characters.erase(character)
		character.queue_free()

func get_character_by_id(char_index:int) -> CharacterController:
	for character in characters:
		if character.char_index == char_index:
			return character 
	return null

func get_character_at(x:int, y:int) -> CharacterController:
	for character in characters:
		if character.grid_position == Vector2i(x, y):
			return character 
	return null
	
func create_item(x:int, y:int, grh_id:int) -> void: 
	if grh_id == 0: 
		return
	if ContentManager.grh_data[grh_id].frames_count > 1:
		grh_id = ContentManager.grh_data[grh_id].frames[1]
	
	var grh = ContentManager.grh_data[grh_id]
	if grh.file_num == 0: 
		return
		
	var sprite = Sprite2D.new()  
	sprite.region_enabled = true
	sprite.region_rect = grh.region
	sprite.self_modulate = Color.BROWN
	sprite.texture = ContentManager.get_texture(grh.file_num)
	sprite.position = Vector2(((x - 1) * 32) + 16, ((y - 1) * 32) + 32)
	sprite.offset = Vector2(0, -sprite.region_rect.size.y / 2) 
	
	map.add_overlap_entity(sprite)
	items.get_or_add(Vector2i(x, y), sprite)
	
func delete_item(x:int, y:int) -> void:
	var node = items.get(Vector2i(x, y))
	if node: 
		node.queue_free()
		items.erase(Vector2i(x, y))
