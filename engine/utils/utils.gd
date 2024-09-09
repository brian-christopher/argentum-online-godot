extends RefCounted
class_name Utils

const email_pattern := r"^[\w\.\+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$"

static func heading_to_vector(heading:int) -> Vector2:
	var retval = Vector2.ZERO
	
	match heading:
		Enums.Heading.NORTH:
			retval = Vector2.UP 
		Enums.Heading.SOUTH:
			retval = Vector2.DOWN 
		Enums.Heading.WEST:
			retval = Vector2.LEFT 
		Enums.Heading.EAST:
			retval = Vector2.RIGHT 
	return retval

static func vector_to_heading(direction:Vector2) -> int:
	if (direction == Vector2.LEFT):
		return Enums.Heading.WEST;
	elif (direction == Vector2.RIGHT):
		return Enums.Heading.EAST;
	elif (direction == Vector2.UP):
		return Enums.Heading.NORTH;
	elif (direction == Vector2.DOWN):
		return Enums.Heading.SOUTH;
	
	if (direction == Vector2(-1, -1)):
		return Enums.Heading.WEST;
	elif (direction == Vector2(-1, 1)):
		return Enums.Heading.WEST;
	elif (direction == Vector2(1, -1)):
		return Enums.Heading.EAST;
	elif (direction == Vector2(1, 1)):
		return Enums.Heading.EAST; 
	
	return Enums.Heading.NONE;

static func in_map_bounds(x:int, y:int) -> bool:
	return x >= 1 && x <= Declares.MAP_WIDTH && \
		   y >= 1 && y <= Declares.MAP_HEIGHT
		
static func string_has_valid_characters(p_str:String) -> bool:
	for i in p_str.length():
		if !Utils.is_legal_character(p_str.unicode_at(i)): 
			return false 
	return true

static func is_legal_character(key_code:int) -> bool:
	if key_code == 8:
		return true
	
	if key_code < 32 || key_code == 44:
		return false
	
	if key_code > 126:
		return false
	
	if key_code in [34, 42, 47, 58, 60, 62, 63, 92, 124]:
		return false 
		
	return true 
	
static func is_valid_email(email: String) -> bool:
	var regex = RegEx.new()
	regex.compile("^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$") 
	 
	return regex.search(email) != null
	
static func show_message_box(title:String, content:String, parent:Node) -> AcceptDialog:
	var dialog = AcceptDialog.new()
	parent.add_child(dialog)
	
	dialog.canceled.connect(func(): dialog.queue_free())
	dialog.confirmed.connect(func(): dialog.queue_free()) 
	dialog.dialog_hide_on_ok = false
	dialog.title = title
	dialog.dialog_text = content 
	dialog.popup_centered() 
	return dialog
