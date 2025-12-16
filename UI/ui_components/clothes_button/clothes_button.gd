@tool
class_name Clothes_Button_Container extends VBoxContainer

@export var item_id:Items_DB.ITEM
@export var clothing_title:String = "Head":
	set(v):
		clothing_title = v
		$clothing_title.text = clothing_title

@export var clothing_icon:String = "None_Icon":
	set(v):
		clothing_icon = v
		var path_base = "res://assets/"
		if clothing_icon != "None_Icon":
			path_base += "clothing_icons/"
			
		$Clothes_Button.texture_normal = load(path_base + clothing_icon +".png" )

func _ready():
	%Custom_Tooltip.get_content_from_item(item_id)


func _on_clothes_button_mouse_entered() -> void:
	%Custom_Tooltip.top_level = true
	%Custom_Tooltip.global_position = $Clothes_Button.global_position - Vector2(%Custom_Tooltip.size.x+10, %Custom_Tooltip.size.y/2 - $Clothes_Button.size.y/2)
	%Custom_Tooltip.show()


func _on_clothes_button_mouse_exited() -> void:
	%Custom_Tooltip.hide()
