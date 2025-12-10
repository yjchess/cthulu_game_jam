class_name Stats_Manager extends Node

signal levellable_stat_change(stat_id:int, levels:int)
signal auto_study_level_changed(level:int)

var                           stats_data:Stats_Data = Stats_Data.new()
var levellable_stat_handler:Levellable_Stat_Handler = Levellable_Stat_Handler.new(stats_data)
var     modifier_stat_handler:Modifier_Stat_Handler = Modifier_Stat_Handler.new(stats_data)

func _ready():
	stats_data       .auto_study_level_changed .connect(self .auto_study_level_changed .emit)
	levellable_stat_handler .levellable_stat_change .connect(self .levellable_stat_change   .emit)
	#levellable_stat_handler .levellable_stat_change .connect(func(stat_id, levels): self.levellable_stat_change.emit(stat_id, levels))
	

func increment_levellable_stat(stat_id:int, amount:int = 1, is_free:bool = false):
	levellable_stat_handler.increment_stat(stat_id, amount, is_free)

func handle_day_ended():
	stats_data.money += stats_data.benefits_per_day
	
func get_enabled_add_stats():
	return levellable_stat_handler.get_enabled_add_stats()

func get_levellable_stat(stat_id:int):
	return levellable_stat_handler.get_levellable_stat(stat_id)

func get_modifier_stats() -> Array[Modifier_Stat]:
	return modifier_stat_handler.modifier_stats
