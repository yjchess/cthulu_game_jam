class_name UI_Handler extends CanvasLayer

enum Upgrade_Selection{
	SKILLS,
	CLOTHING,
	DESK,
	OTHER,
	DOOR
}

enum Upgrade_View_Areas{
	CURRENT,
	SKILLS
}

var upgrade_selection_buttons:ButtonGroup = preload("res://UI/ui_components/upgrade_view_buttons/button_groups/upgrade_selection.tres")
var upgrade_selected_areas:ButtonGroup = preload("res://UI/ui_components/upgrade_view_buttons/button_groups/upgrade_area_selection.tres")
var current_upgrade_view:Upgrade_Selection = Upgrade_Selection.SKILLS
var current_upgrade_area_view:Upgrade_View_Areas = Upgrade_View_Areas.CURRENT

signal skills_shop_view
signal add_button_pressed
signal project_selected

func convert_enum_to_string(enum_name, enum_value):
	var stringified:String = enum_name.keys()[enum_value].capitalize()
	return stringified
	

func _ready() -> void:
	#%Money_Value.text = "£"+ str(Stats_Handler.money)
	
	for button: Radio_Buttons in upgrade_selection_buttons.get_buttons():
		button.pressed.connect(update_current_view_selection)
	
	for button: Radio_Buttons in upgrade_selected_areas.get_buttons():
		button.pressed.connect(update_current_view_area_selected)
	
	for ui_skill:UI_Skill_View in get_tree().get_nodes_in_group("ui_skill"):
		ui_skill.add_button_pressed.connect(self.add_button_pressed.emit)

func populate_projects(projects: Array[Progress_Handler.Project_Progress]):
	for project:Progress_Handler.Project_Progress in projects:
		var item_name = convert_enum_to_string(Progress_Handler.Projects, project.project_id)
		%Current_Project.add_item(item_name, project.project_id)
		%Current_Project.set_item_disabled(project.project_id, !project.enabled)

func get_current_project() -> int:
	return %Current_Project.get_item_id(%Current_Project.selected)

func get_location():
	return %Location.get_item_id(%Location.selected)

func update_stat_view(stat_index:int, stat_value:int):
	var skill_view:UI_Skill_View = get_stat_view(stat_index)
	if skill_view != null:
		skill_view.set_value(stat_value)
	
	refresh_view()

func get_stat_view(stat_index:int):
	var ui_skills = get_tree().get_nodes_in_group("ui_skill")
	for skill: UI_Skill_View in ui_skills:
		if skill.skill_index == stat_index:
			return skill
	return null


func _on_current_button_pressed() -> void:
	
	get_tree().call_group("upgrade_views_containers", "hide")
	match current_upgrade_view:
		Upgrade_Selection.SKILLS:
			%Skills_View_Container.show()
			get_tree().call_group("ui_skill","current_view")
	pass # Replace with function body.

func update_current_view_selection():
	var button:Radio_Buttons = upgrade_selection_buttons.get_pressed_button()
	current_upgrade_view = button.id
	refresh_view()
	return button.id

func update_current_view_area_selected():
	var button:Radio_Buttons = upgrade_selected_areas.get_pressed_button()
	current_upgrade_area_view = button.id
	refresh_view()
	return button.id

func _on_shop_button_pressed() -> void:
	get_tree().call_group("upgrade_views_containers", "hide")
	match current_upgrade_view:
		Upgrade_Selection.SKILLS:
			%Skills_View_Container.show()
			emit_signal("skills_shop_view")
	pass # Replace with function body.

func display_skills_shop_view(addable_stats:Array = []):
	
	for stat_view:UI_Skill_View in get_tree().get_nodes_in_group("ui_skill"):
		var can_add = false
		
		if stat_view.skill_index in addable_stats:
			can_add = true
		
		stat_view.shop_view(can_add)


func refresh_view():

	match current_upgrade_view:
		Upgrade_Selection.SKILLS:
			if current_upgrade_area_view == Upgrade_View_Areas.CURRENT:
				_on_current_button_pressed()
			else:
				_on_shop_button_pressed()
		


func _on_current_project_item_selected(index: int) -> void:
	emit_signal("project_selected", index)

func process_second(time_text:String):
	%Time_Value.text = time_text

func unlock_project(project_id:int):
	print("HI")
	%Current_Project.set_item_disabled(project_id, false)
