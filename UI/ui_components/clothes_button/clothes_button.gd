class_name Clothes_Button_Container extends VBoxContainer

@export var item_id:Items_DB.ITEM
@export var clothing_title:String = "Head":
	set(v):
		clothing_title = v
		$clothing_title.text = clothing_title

var clothing_icon:String = "res://assets/None_Icon.png":
	set(v):
		clothing_icon = v
		$Clothes_Button.texture_normal = load(clothing_icon)

func _ready():
	var item = Items_DB.get_item(item_id)
	%Custom_Tooltip.get_content_from_item(item_id)
	if item == null: return
	if not FileAccess.file_exists(item.path): return
	
	clothing_icon = item.path
	


func _on_clothes_button_mouse_entered() -> void:
	%Custom_Tooltip.top_level = true
	%Custom_Tooltip.global_position = $Clothes_Button.global_position - Vector2(%Custom_Tooltip.size.x+10, %Custom_Tooltip.size.y/2 - $Clothes_Button.size.y/2)
	%Custom_Tooltip.show()


func _on_clothes_button_mouse_exited() -> void:
	%Custom_Tooltip.hide()
