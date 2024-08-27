extends Node2D
class_name CharacterRenderer

enum {
	IDLE_DOWN,
	IDLE_UP,
	IDLE_LEFT,
	IDLE_RIGHT,
	WALK_DOWN,
	WALK_UP,
	WALK_LEFT,
	WALK_RIGHT
}

var current_state:int = IDLE_DOWN
var current_heading:int = Enums.Heading.SOUTH

func get_animation_resource(path:String) -> SpriteFrames:
	if !ResourceLoader.exists(path):
		return load("res://resources/default_animation.tres")
	return load(path)

func set_weapon(id:int) -> void:  
	%Weapon.sprite_frames = get_animation_resource("res://resources/weapons/weapon_%d.tres" % id)
	
func set_shield(id:int) -> void:
	%Shield.sprite_frames = get_animation_resource("res://resources/shields/shield_%d.tres" % id)
	
func set_head(id:int) -> void:
	%Head.sprite_frames = get_animation_resource("res://resources/heads/head_%d.tres" % id)
	
func set_helmet(id:int) -> void:
	%Helmet.sprite_frames = get_animation_resource("res://resources/helmets/helmet_%d.tres" % id)

func set_body(id:int) -> void:
	%Body.sprite_frames = get_animation_resource("res://resources/bodies/body_%d.tres" % id)
	if(%Body.sprite_frames.get_frame_count("idle_down") == 0):
		position = Vector2.ZERO
	else:
		var offset_y = %Body.sprite_frames\
			.get_frame_texture("idle_down", 0)\
			.get_height() / 2
		position = Vector2(0, -offset_y) 

func play(animation_name:String) -> void:
	%Weapon.play(animation_name)
	%Body.play(animation_name)
	%Weapon.play(animation_name)
	%Shield.play(animation_name)
	
	%Helmet.play(animation_name.replace("walk", "idle"))
	%Head.play(animation_name.replace("walk", "idle"))
