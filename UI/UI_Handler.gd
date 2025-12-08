class_name UI_Handler extends CanvasLayer

enum Room_Projects{
	STUDY_CODE,
	STUDY_ART
}

enum Upgrade_View_Selections{
	SKILLS,
	CLOTHING,
	DESK,
	OTHER,
	DOOR
}

var upgrade_selection_buttons:ButtonGroup = preload("res://UI/ui_components/upgrade_view_buttons/button_groups/upgrade_view_radio_buttons.tres")
var current_upgrade_view

func convert_enum_to_string(enum_name, enum_value):
	var stringified:String = enum_name.keys()[enum_value].capitalize()
	return stringified
			
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in len(Room_Projects.values()):
		var item_name = convert_enum_to_string(Room_Projects, i)
		%Current_Project.add_item(item_name, i)
		
	convert_enum_to_string(Room_Projects, Room_Projects.STUDY_CODE)



func get_current_project():
	return %Current_Project.get_item_id(%Current_Project.selected)

func get_location():
	return %Location.get_item_id(%Location.selected)

func increment_stat_view(stat_index:int):
	var skill_view:UI_Skill_View = get_stat_view(stat_index)
	if skill_view != null:
		skill_view.increment_value()

func get_stat_view(stat_index:int):
	var ui_skills = get_tree().get_nodes_in_group("ui_skill")
	for skill: UI_Skill_View in ui_skills:
		if skill.skill_index == stat_index:
			return skill
	return null


func _on_current_button_pressed() -> void:
	update_current_view_selection()
	get_tree().call_group("upgrade_views_containers", "hide")
	match current_upgrade_view:
		Upgrade_View_Selections.SKILLS:
			%Skills_View_Container.show()
			get_tree().call_group("ui_skill","current_view")
	pass # Replace with function body.

func update_current_view_selection():
	var button:Radio_Buttons = upgrade_selection_buttons.get_pressed_button()
	current_upgrade_view = button.id
	return button.id


func _on_shop_button_pressed() -> void:
	update_current_view_selection()
	get_tree().call_group("upgrade_views_containers", "hide")
	match current_upgrade_view:
		Upgrade_View_Selections.SKILLS:
			%Skills_View_Container.show()
			get_tree().call_group("ui_skill","shop_view")
	pass # Replace with function body.
