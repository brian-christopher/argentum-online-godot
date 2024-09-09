extends Node2D
class_name CharacterController
@export var renderer:CharacterRenderer
@export var character_fx:CharacterFx

var char_index:int
var grid_position:Vector2i

var is_moving:bool
var heading:int = Enums.Heading.SOUTH
var target_position:Vector2

var speed:float = 140
var privs:int
var criminal:bool
var pie:bool

func move_to_heading(p_heading: int) -> void:
	if is_moving:
		position = target_position
	var offset = Utils.heading_to_vector(p_heading)
	is_moving = true
	target_position = position + (offset * 32)
	

func _process(delta: float) -> void:
	process_movement(delta)
	procces_animation()

func process_movement(delta:float) -> void:
	if !is_moving: return
	position = position.move_toward(target_position, speed * delta)
	if position.distance_to(target_position) < 0.01:
		position = target_position
		is_moving = false

func procces_animation() -> void:
	if is_moving:
		renderer.play("walk_" + heading_to_string(heading))
	else:
		renderer.play("idle_" + heading_to_string(heading))

func set_character_name(p_name:String) -> void:
	%Name.text = p_name

func set_character_name_color(color:Color) -> void:
	%Name.self_modulate = color

func talk(msg:String, color:Color = Color.WHITE) -> void:
	$Talk.show()
	$Talk.text = msg
	$Talk.self_modulate = color
	$TalkTimeout.start(10)

func _on_talk_timeout_timeout() -> void:
	$Talk.hide()

func heading_to_string(p_heading:int) -> String:
	match p_heading:
		Enums.Heading.NORTH:
			return "up"
		Enums.Heading.SOUTH:
			return "down"
		Enums.Heading.EAST:
			return "right"
		Enums.Heading.WEST:
			return "left"
	return ""

func update_tag_color() -> void:
	if privs == 0:
		if criminal:
			set_character_name_color(ContentManager.colores_pj[50])
		else:
			set_character_name_color(ContentManager.colores_pj[49])
	else:
		set_character_name_color(ContentManager.colores_pj[privs])
