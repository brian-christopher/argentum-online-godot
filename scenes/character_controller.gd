extends Node2D
class_name CharacterController

var char_index:int
var grid_position:Vector2i

var is_moving:bool
var heading:int
var target_position:Vector2

var speed:float = 140

func move_to_heading(heading: int) -> void:
	var offset = Utils.heading_to_vector(heading) 
	is_moving = true
	target_position = position + (offset * 32)
	
func _physics_process(delta: float) -> void:
	process_movement(delta)

func process_movement(delta:float) -> void:
	if !is_moving: return 
	position = position.move_toward(target_position, speed * delta)
	if position == target_position:
		is_moving = false
