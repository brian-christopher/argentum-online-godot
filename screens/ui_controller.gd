extends CanvasLayer
class_name UIController

@export var rich_text:RichTextLabel
@export var send_text:LineEdit



func append_text(text:String) -> void:
	rich_text.append_text(text + "\n")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed && event.keycode == KEY_ENTER:
			send_text.show()
			send_text.grab_focus()

 
func _on_main_view_gui_input(event: InputEvent) -> void:
	pass # Replace with function body.


func _on_send_text_text_submitted(new_text: String) -> void:
	if new_text.is_empty():
		return
	send_text.text = ""
	send_text.hide()
	
	var p = TalkRequest.new()
	p.message = new_text
	SessionManager.send_packet(p)
