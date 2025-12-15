@tool extends HBoxContainer

@export var goal_text:String = "Coding + Art Lvl 1":
	set(v):
		$Label.text = v
		goal_text = v

@export var font_color:Color = Color.WHITE:
	set(v):
		font_color = v
		$Label.add_theme_color_override("font_color", font_color)

func completed():
	$CheckBox.button_pressed = true
