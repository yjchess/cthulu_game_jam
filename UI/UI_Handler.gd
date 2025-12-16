class_name UI_Handler extends CanvasLayer

@onready var upgrades_view_handler:Upgrades_View_Handler = $Upgrades_View


var event_log = preload("res://UI/ui_components/Event_Log/event_log.tscn")

signal skills_shop_view
signal add_button_pressed
signal project_selected

func _ready():
	upgrades_view_handler.add_button_pressed.connect(self.add_button_pressed.emit)
	upgrades_view_handler.skills_shop_view.connect(self.skills_shop_view.emit)

func convert_enum_to_string(enum_name, enum_value):
	var stringified:String = enum_name.keys()[enum_value].capitalize()
	return stringified
	

func populate_projects(projects: Array[Progress_Handler.Project_Progress]):
	for project:Progress_Handler.Project_Progress in projects:
		var item_name = convert_enum_to_string(Progress_Handler.Projects, project.project_id)
		%Current_Project.add_item(item_name, project.project_id)
		%Current_Project.set_item_disabled(project.project_id, !project.enabled)
		
		var tooltip:String = project.tooltip
		if not project.enabled:
			tooltip = project.disabled_tooltip
			
		%Current_Project.set_item_tooltip(project.project_id, tooltip)
		
func get_current_project() -> int:
	return %Current_Project.get_item_id(%Current_Project.selected)

func get_location():
	return %Location.get_item_id(%Location.selected)



func modifier_stat_changed(modifier_id, modifier_value):
	var modifier_stat_view = %Modifier_Stats_Container.get_child(modifier_id)
	modifier_stat_view.progress_bar.value = modifier_value



func _on_current_project_item_selected(index: int) -> void:
	emit_signal("project_selected", index)

func process_second(time_text:String):
	%Time_Value.text = time_text

func day_ended(current_day:int):
	var old_text = %Day_Value.text
	%Day_Value.text = str( current_day ) + "/28"

func season_ended(current_season:int):
	match current_season:
		1: %Season_Value.text = "Spring"
		2: %Season_Value.text = "Summer"
		3: %Season_Value.text = "Autumn"
		4: %Season_Value.text = "Winter"
			
func year_ended(current_year:int):
	%Year_Value.text = str(current_year)
	
func unlock_project(project_id:int):
	%Current_Project.set_item_disabled(project_id, false)

func populate_modifier_stat_container(modifier_stats:Array[Modifier_Stat]):
	var modifier_stat_containers = get_tree().get_nodes_in_group("Modifier_Stat_Display")
	for container:Modifier_Stat_View in modifier_stat_containers:
		var corresponding_stat:Modifier_Stat
		for stat:Modifier_Stat in modifier_stats:
			if stat.id == container.id:
				corresponding_stat = stat
				break
		container.progress_bar.value = corresponding_stat.value

func update_money_view(money:float):
	%Money_Value.text = "£"+str(money)

func handle_event(event_id:Enums.EVENTS_LOG, variables:Variant = null):
	match event_id:
		Enums.EVENTS_LOG.BENEFITS_RECEIVED:
			var new_log: Label = event_log.instantiate()
			new_log.text = "Received benefits of: £"+variables[Enums.EVENTS_LOG_VARIABLES.AMOUNT]
			%Event_Logs_Container.add_child(new_log)
		Enums.EVENTS_LOG.RENT_PAID:
			var new_log: Label = event_log.instantiate()
			new_log.text = "Paid Monthly Rent of: £"+variables[Enums.EVENTS_LOG_VARIABLES.AMOUNT]
			%Event_Logs_Container.add_child(new_log)


#upgrades_view_handler bus functions
func display_skills_shop_view(addable_stats:Array = []):
	upgrades_view_handler.display_skills_shop_view(addable_stats)

func update_stat_view(stat_index:int, stat_value:int):
	upgrades_view_handler.update_stat_view(stat_index, stat_value)

func refresh_view():
	upgrades_view_handler.refresh_view()
