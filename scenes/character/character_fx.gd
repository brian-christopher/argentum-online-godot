extends AnimatedSprite2D
class_name CharacterFx

var loops:int
var count:int
var fx_id:int

func start_fx(p_id:int, p_loops:int) -> void:
	loops = p_loops
	fx_id = p_id
	count = 0
	
	if fx_id == 0:
		stop_fx()
		return
	
	sprite_frames = load("res://resources/fxs/fx_%d.tres" % fx_id)	
	var offset_y = sprite_frames\
			.get_frame_texture("default", 0)\
			.get_height() / 2
	position = Vector2(0, -offset_y) 			
	visible = true
	frame = 0
	play("default")	

func stop_fx() -> void:
	visible = false
	stop()
	
func _on_animation_finished() -> void:
	count += 1
	
	if count > loops && loops != -1:
		stop_fx()
	else:
		frame = 0
		play("default")
