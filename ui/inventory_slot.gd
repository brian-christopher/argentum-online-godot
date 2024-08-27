extends Panel
class_name InventorySlot
signal pressed

@export var icon_texture:TextureRect
@export var quantity_label:Label
@export var equipped_label:Label

var slot_index:int

func set_item(item:Item) -> void:
	icon_texture.texture = item.icon
	
func set_equipped(v:bool) -> void:
	equipped_label.visible = v
	
func set_quantity(quantity:int) -> void:
	quantity_label.visible = quantity > 1
	quantity_label.text = str(quantity)
	
func set_selected(v:bool) -> void:
	$Selected.visible = v

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			pressed.emit()
