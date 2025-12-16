class_name Modifier_Stat extends Node
var value: float = 100.0:
	set(v):
		value = v
		emit_signal("stat_changed", id, v)

var has_max: bool = false
var max:float = 100.0
var stat_name:String = "Energy"
var id:Enums.MODIFIER_STATS = Enums.MODIFIER_STATS.ENERGY
var optimal_range:Array = [] #only used for temperature
var has_optimal_range: bool = false
signal stat_changed

#when the value drops beneath the limit - the project progress is reduced by timesing the limit_effects
var limits = [20, 30]
var limit_effects = [0.5, 0.7]
var stats_data: Stats_Data

func _init(stats_data:Stats_Data, id:Enums.MODIFIER_STATS, stat_name:String, max:float = 100.0, limits:Array = [20,30], limit_effects = [0.5, 0.7], optimal_range:Array = []):
	self.    stats_data = stats_data
	self.            id = id
	self.     stat_name = stat_name
	self.        limits = limits
	self. limit_effects = limit_effects
	
	if max != 100.0:
		self.has_max = true
		self.value = max
		self.max = max
	
	
	if optimal_range != []:
		self.has_optimal_range = true
		self.optimal_range = optimal_range
		self.value = 50.0
