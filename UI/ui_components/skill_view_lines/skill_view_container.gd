@tool
class_name UI_Skill_View extends HBoxContainer

@export var skill_title:String = "Coding":
	set(v):
		skill_title = v
		%skill_title.text = v
		
@export var skill_value:int = 0:
	set(v):
		skill_value = v
		%skill_value.text = str(v)

@export var skill_index:int = 0
@export var has_add:bool = true
@export var skill_title_tooltip:String = "Tooltip"


enum states {
	CURRENT,
	SHOP
}

signal change_view
signal add_button_pressed

func _ready():
	current_view()
	%skill_title.tooltip_text = skill_title_tooltip

func set_value(amount:int):
	skill_value = amount
	
func current_view():
	%Add_Button.hide()

func shop_view(can_add:bool = false):
	if not has_add:
		return
	
	%Add_Button.show()
	if can_add:
		%Add_Button.disabled = false
	else:
		%Add_Button.disabled = true



func _on_add_button_pressed() -> void:
	emit_signal("add_button_pressed", skill_index)
	
