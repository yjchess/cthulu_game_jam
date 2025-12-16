class_name Levellable_Stat_Handler extends Node

var stats_data:Stats_Data
var levellable_stats:Array[Levellable_Stat]
signal levellable_stat_change(stat_id:int, levels:int)
signal auto_study_level_changed

func _init(stats_data:Stats_Data):
	self.stats_data = stats_data
	levellable_stats = [
		Levellable_Stat.new(stats_data,     "Coding", Enums.LEVEL_STATS.CODING          ),
		Levellable_Stat.new(stats_data,        "Art", Enums.LEVEL_STATS.ART             ),
		Levellable_Stat.new(stats_data, "Auto Study", Enums.LEVEL_STATS.AUTO_STUDY, 1, 1),
		Levellable_Stat.new(stats_data,    "Web Dev", Enums.LEVEL_STATS.WEB_DEV,    1   ),
		Levellable_Stat.new(stats_data,   "Game Dev", Enums.LEVEL_STATS.GAME_DEV,   1   ),
		Levellable_Stat.new(stats_data,   "Dig. Art", Enums.LEVEL_STATS.DIG_ART,    0, 1),
		Levellable_Stat.new(stats_data,  "Trad. Art", Enums.LEVEL_STATS.TRAD_ART,   0, 1),
	]



func get_levellable_stat(stat_id: Enums.LEVEL_STATS) -> Levellable_Stat:
	for stat:Levellable_Stat in levellable_stats:
		if stat.id == stat_id:
			return stat
	return null

func get_levellable_stats():
	return levellable_stats

func can_add(stat_index:int, free:bool = false):
	var stat:Levellable_Stat = get_levellable_stat(stat_index)
	return stat.can_add(free)
	
	
func increment_stat(stat_id:int, amount:int = 1, is_free:bool = false):
	if stat_id <2: is_free = true # id 0 = coding id 1 = art
	var stat:Levellable_Stat = get_levellable_stat(stat_id)
	if not stat.can_add(is_free): return
	stat.add(is_free, amount)
	
	match stat.id:
		Enums.LEVEL_STATS.AUTO_STUDY: emit_signal("auto_study_level_changed", stats_data.auto_study_level)

	levellable_stat_change.emit(stat_id, stat.levels)


func get_enabled_add_stats():
	var enabled_stats_ids = []
	for stat:Levellable_Stat in levellable_stats:
		if stat.id < 2: #coding and art never display add button
			continue
		if stat.can_add(): enabled_stats_ids.append(stat.id)
	
	return enabled_stats_ids
