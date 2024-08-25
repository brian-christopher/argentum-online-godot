extends Panel
class_name LoginPanel

signal quit_button_pressed()
signal login_button_pressed()
signal register_button_pressed()
signal error(str:String)
  
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
	%Password.editable = false
	%Username.editable = false
	
func enable_auth_buttons() -> void:
	%Login.disabled = false
	%Register.disabled = false
	%Password.editable = true
	%Username.editable = true

func _on_login_pressed() -> void: 
	var username = get_username()
	var password = get_password()
	
	if username.is_empty():
		error.emit("Ingrese un nombre de personaje") 
		return
	
	if password.is_empty():
		error.emit("Ingrese un password")
		return
	
	if username.length() > 30:
		error.emit("El nombre debe tener menos de 30 letras.")  
		return			
		
	if !Utils.string_has_valid_characters(username):
		error.emit("Nombre con caracter invalido.")   
		return

	if !Utils.string_has_valid_characters(password):
		error.emit("Password con caracter invalido.")   
		return
		
	login_button_pressed.emit()
