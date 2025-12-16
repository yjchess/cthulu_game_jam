class_name Stats_Manager extends Node

signal levellable_stat_change(stat_id:int, levels:int)
signal auto_study_level_changed(level:int)
signal money_changed
signal events_log(event_id:Enums.EVENTS_LOG, variables:Dictionary)
signal modifier_stat_changed

var                           stats_data:Stats_Data = Stats_Data.new()
var levellable_stat_handler:Levellable_Stat_Handler = Levellable_Stat_Handler.new(stats_data)
var     modifier_stat_handler:Modifier_Stat_Handler = Modifier_Stat_Handler.new(stats_data)

func _ready():
	stats_data                       .money_changed .connect(self .money_changed            .emit)
	stats_data            .auto_study_level_changed .connect(self .auto_study_level_changed .emit)
	levellable_stat_handler .levellable_stat_change .connect(self .levellable_stat_change   .emit)
	modifier_stat_handler.stat_changed.connect(self.modifier_stat_changed.emit)
	#levellable_stat_handler .levellable_stat_change .connect(func(stat_id, levels): self.levellable_stat_change.emit(stat_id, levels))
	

func increment_levellable_stat(stat_id:int, amount:int = 1, is_free:bool = false):
	levellable_stat_handler.increment_stat(stat_id, amount, is_free)

func handle_hour_ended():
	modifier_stat_handler.handle_hour_ended()

func handle_day_ended():
	stats_data.money += stats_data.benefits_per_day
	emit_signal("events_log", Enums.EVENTS_LOG.BENEFITS_RECEIVED, {Enums.EVENTS_LOG_VARIABLES.AMOUNT: str(stats_data.benefits_per_day)})

func handle_month_ended():
	stats_data.money -= stats_data.monthly_rent
	emit_signal("events_log", Enums.EVENTS_LOG.RENT_PAID, {Enums.EVENTS_LOG_VARIABLES.AMOUNT: str(stats_data.monthly_rent)})

func handle_year_ended():
	pass

func get_enabled_add_stats():
	return levellable_stat_handler.get_enabled_add_stats()

func get_levellable_stat(stat_id:int):
	return levellable_stat_handler.get_levellable_stat(stat_id)

func get_modifier_stats() -> Array[Modifier_Stat]:
	return modifier_stat_handler.modifier_stats

func finished_project(project_id:int):
	if project_id in [Progress_Handler.Projects.HOBBY_SITE, Progress_Handler.Projects.HOBBY_GAME]:
		stats_data.project_points += 1

	elif project_id in [Progress_Handler.Projects.WEBSITE, Progress_Handler.Projects.GAME]:
		stats_data.project_points += 5
		stats_data.money += 10.00
	
	if project_id in [Progress_Handler.Projects.STUDY_CODE, Progress_Handler.Projects.STUDY_ART]:
		increment_levellable_stat(project_id, 1, true)
