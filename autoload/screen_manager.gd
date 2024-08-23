extends Node

var _current_screen:Node

func switch_screen(screen:Node) -> void:
	if _current_screen:
		_current_screen.queue_free()
	
	_current_screen = screen
	add_child(screen)
