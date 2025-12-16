class_name Modifier_Stat_Handler extends Node

var stats_data:Stats_Data
var modifier_stats:Array[Modifier_Stat] = [
	Modifier_Stat.new(stats_data, Enums.MODIFIER_STATS.ENERGY, "Energy", 80.0),
	Modifier_Stat.new(stats_data, Enums.MODIFIER_STATS.TEMPERATURE, "Temperature", 100.0, [], [], [30, 70]),
	Modifier_Stat.new(stats_data, Enums.MODIFIER_STATS.COMFORT, "Comfort", 80.0),
	Modifier_Stat.new(stats_data, Enums.MODIFIER_STATS.MENTAL_HP, "Mental HP", 80.0),
	Modifier_Stat.new(stats_data, Enums.MODIFIER_STATS.PHYSICAL_HP, "Physical HP", 70.0)
]
signal stat_changed(id:int, value:float)

func _init(stats_data:Stats_Data):
	self.stats_data = stats_data
	for modifier_stat in modifier_stats:
		modifier_stat.stat_changed.connect(self.stat_changed.emit)


func get_modifier_stat(stat_id: Enums.MODIFIER_STATS) -> Modifier_Stat:
	for stat:Modifier_Stat in modifier_stats:
		if stat.id == stat_id:
			return stat
	return null

func get_modifier_stats():
	return modifier_stats

func handle_hour_ended():
	var energy_stat = get_modifier_stat(Enums.MODIFIER_STATS.ENERGY)
	energy_stat.value -= stats_data.energy_cost_per_hour
	
