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
@export var spends_coding:bool = true
@export var spends_art: bool = false

enum states {
	CURRENT,
	SHOP
}

func _ready():
	current_view()

func increment_value(amount:int = 1):
	skill_value = skill_value + amount

func current_view():
	%Add_Button.hide()

func shop_view():
	if has_add:
		%Add_Button.show()
		if can_add():
			%Add_Button.disabled = false
		else:
			%Add_Button.disabled = true

func can_add():
	if spends_coding and Stats_Handler.unspent_coding_levels > 0:
		return true
	
	if spends_art and Stats_Handler.unspent_art_levels > 0:
		return true
		
	return false


func _on_add_button_pressed() -> void:
	if not can_add():
		return
		
	if spends_coding and Stats_Handler.unspent_coding_levels > 0:
		Stats_Handler.unspent_coding_levels 
