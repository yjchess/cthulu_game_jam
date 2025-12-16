class_name Upgrades_View_Handler extends Control

var upgrade_selection_buttons:ButtonGroup = preload("res://UI/ui_components/upgrade_view_buttons/button_groups/upgrade_selection.tres")
var upgrade_selected_areas:ButtonGroup = preload("res://UI/ui_components/upgrade_view_buttons/button_groups/upgrade_area_selection.tres")
var current_upgrade_view:Enums.Upgrade_Selection = Enums.Upgrade_Selection.SKILLS
var current_upgrade_area_view:Enums.Upgrade_View_Areas = Enums.Upgrade_View_Areas.CURRENT

signal skills_shop_view
signal add_button_pressed

func _ready() -> void:
	#%Money_Value.text = "£"+ str(Stats_Handler.money)
	
	for button: Radio_Buttons in upgrade_selection_buttons.get_buttons():
		button.pressed.connect(update_current_view_selection)
	
	for button: Radio_Buttons in upgrade_selected_areas.get_buttons():
		button.pressed.connect(update_current_view_area_selected)
	
	for ui_skill:UI_Skill_View in get_tree().get_nodes_in_group("ui_skill"):
		ui_skill.add_button_pressed.connect(self.add_button_pressed.emit)
		
func _on_shop_button_pressed() -> void:
	get_tree().call_group("upgrade_views_containers", "hide")
	match current_upgrade_view:
		Enums.Upgrade_Selection.SKILLS:
			%Skills_View.show()
			emit_signal("skills_shop_view")
		
		Enums.Upgrade_Selection.CLOTHING:
			%Clothing_View.show()
			%Current_Clothing_View.hide()
			%Shop_Clothing_View.show()
			await get_tree().process_frame
			%Shop_Clothing_View.update_tooltip_global_positions()
		
		Enums.Upgrade_Selection.DESK:
			%Desk_View.show()
			%Current_Desk_View.hide()
			%Shop_Desk_View.show()
		
		Enums.Upgrade_Selection.OTHER:
			%Other_View.show()
			%Current_Other_View.hide()
			%Shop_Other_View.show()
		
		Enums.Upgrade_Selection.DOOR:
			%Door_View.show()
			%Current_Door_View.hide()
			%Shop_Door_View.show()


func display_skills_shop_view(addable_stats:Array = []):
	
	for stat_view:UI_Skill_View in get_tree().get_nodes_in_group("ui_skill"):
		var can_add = false
		
		if stat_view.skill_index in addable_stats:
			can_add = true
		
		stat_view.shop_view(can_add)

func refresh_view():
	if current_upgrade_area_view == Enums.Upgrade_View_Areas.CURRENT:
		_on_current_button_pressed()
	else:
		_on_shop_button_pressed()
	
				
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
		Enums.Upgrade_Selection.SKILLS:
			%Skills_View.show()
			get_tree().call_group("ui_skill","current_view")
		
		Enums.Upgrade_Selection.CLOTHING:
			%Clothing_View.show()
			%Current_Clothing_View.show()
			%Shop_Clothing_View.hide()
		
		Enums.Upgrade_Selection.DESK:
			%Desk_View.show()
			%Current_Desk_View.show()
			%Shop_Desk_View.hide()
		
		Enums.Upgrade_Selection.OTHER:
			%Other_View.show()
			%Current_Other_View.show()
			%Shop_Other_View.hide()
		
		Enums.Upgrade_Selection.DOOR:
			%Door_View.show()
			%Current_Door_View.show()
			%Shop_Door_View.hide()
			
func update_current_view_selection():
	var button:Radio_Buttons = upgrade_selection_buttons.get_pressed_button()
	current_upgrade_view = button.id
	%Upgrade_Title.text = Utilities.convert_enum_to_string(Enums.Upgrade_Selection,button.id)
	refresh_view()
	return button.id

func update_current_view_area_selected():
	var button:Radio_Buttons = upgrade_selected_areas.get_pressed_button()
	current_upgrade_area_view = button.id
	refresh_view()
	return button.id


func _on_other_skills_pressed() -> void:
	%Project_Point_Skills.show()


func _on_exit_button_pressed() -> void:
	%Project_Point_Skills.hide()
