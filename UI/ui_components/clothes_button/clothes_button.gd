@tool
class_name Clothes_Button_Container extends VBoxContainer

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
