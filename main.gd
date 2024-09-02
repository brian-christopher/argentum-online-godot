extends Node

func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.BLACK)
	
	var screen = load("res://screens/lobby_screen.tscn").instantiate()
	ScreenManager.switch_screen(screen)
