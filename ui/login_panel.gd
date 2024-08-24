extends Panel
class_name LoginPanel

signal quit_button_pressed()
signal login_button_pressed()
signal register_button_pressed()
  
func _ready() -> void:
	%Quit.pressed.connect(func(): quit_button_pressed.emit()) 
	%Register.pressed.connect(func(): register_button_pressed.emit()) 

func get_username() -> String:
	return %Username.text
	
func get_password() -> String:
	return %Password.text

func disable_auth_buttons() -> void:
	%Login.disabled = true
	%Register.disabled = true
	
func enable_auth_buttons() -> void:
	%Login.disabled = false
	%Register.disabled = false

func _on_login_pressed() -> void:
	var check_is_string
	
	var username = get_username()
	var password = get_password()
	
	if password.is_empty():
		#MsgBox ("Ingrese un password.")
		return
		
	if username.is_empty():
		#MsgBox ("Ingrese un nombre de personaje.")
		return
		
	if username.length() > 30:
		#MsgBox ("El nombre debe tener menos de 30 letras.")
		return			
		
	if !Utils.string_has_valid_characters(username):
		#MsgBox ("Nombre inválido. El caractér " & Chr$(CharAscii) & " no está permitido.")
		return

	if !Utils.string_has_valid_characters(password):
		#MsgBox ("Password inválido. El caractér " & Chr$(CharAscii) & " no está permitido.")
		return
		
	login_button_pressed.emit()
