class_name Game_Manager extends Node2D
var progress_handler: Progress_Handler = Progress_Handler.new()
var stats_manager: Stats_Manager = Stats_Manager.new()
@onready var time_handler: Time_Handler = %Time_Handler
@onready var ui_handler: UI_Handler = $UI

func _ready() -> void:
	stats_manager._ready()
	progress_handler._ready()
	stats_manager.money_changed.connect(ui_handler.update_money_view)
	ui_handler.populate_projects(progress_handler.get_projects())
	ui_handler.populate_modifier_stat_container(stats_manager.get_modifier_stats())
	progress_handler.progress_bar = $UI/Score_Containers/StatsContainer/ProgressBar
	progress_handler.finished_progress.connect(progress_finished)
	progress_handler.project_enabled.connect(ui_handler.unlock_project)
	stats_manager.levellable_stat_change.connect(stat_changed)
	stats_manager.auto_study_level_changed.connect(time_handler.auto_study_level_changed)
	ui_handler.skills_shop_view.connect(skills_shop_view)
	ui_handler.add_button_pressed.connect(stats_manager.increment_levellable_stat)
	ui_handler.project_selected.connect(progress_handler.change_project)
	time_handler.auto_study_tick.connect(auto_study)
	time_handler.second_passed.connect(ui_handler.process_second)
	time_handler.day_passed.connect(day_ended)
	time_handler.season_passed.connect(season_ended)
	stats_manager.events_log.connect(ui_handler.handle_event)
	

func _on_keyboard_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	
	if (event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT):
		progress_handler.player_click(stats_manager.get_modifier_stats())

func auto_study():
	progress_handler.player_click(stats_manager.get_modifier_stats())
	
func progress_finished():
	var current_project = ui_handler.get_current_project()
	
	stats_manager.finished_project(current_project)
	ui_handler.refresh_view()

func stat_changed(stat_index:int, stat_value:int):
	ui_handler.update_stat_view(stat_index, stat_value)
	var web_dev_level = stats_manager.get_levellable_stat(Enums.LEVEL_STATS.WEB_DEV).levels
	var game_dev_level = stats_manager.get_levellable_stat(Enums.LEVEL_STATS.GAME_DEV).levels

	var trad_art_level = stats_manager.get_levellable_stat(Enums.LEVEL_STATS.TRAD_ART).levels
	var dig_art_level = stats_manager.get_levellable_stat(Enums.LEVEL_STATS.DIG_ART).levels
	progress_handler.check_project_unlocks(web_dev_level, game_dev_level, trad_art_level, dig_art_level)

func skills_shop_view():
	var enabled_add_button_stats = stats_manager.get_enabled_add_stats()
	ui_handler.display_skills_shop_view(enabled_add_button_stats)
	
func day_ended(current_day:int):
	stats_manager.handle_day_ended()
	ui_handler.day_ended(current_day)

func season_ended(current_season:int):
	stats_manager.handle_month_ended()
	ui_handler.season_ended(current_season)

func year_ended(current_year:int):
	stats_manager.handle_year_ended()
	ui_handler.year_ended(current_year)
	
