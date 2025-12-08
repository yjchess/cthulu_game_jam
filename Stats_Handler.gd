class_name Stats_Handler extends Node

static var unspent_coding_levels: int = 0
static var unspent_art_levels: int = 0
static var auto_study_level: int = 0

enum LEVEL_STATS{
	CODING,
	ART,
	AUTO_STUDY,
	WEB_DEV,
	GAME_DEV,
	DIG_ART,
	TRAD_ART
}

enum MODIFIER_STATS{
	ENERGY,
	TEMPERATURE,
	COMFORT,
	MENTAL_HP,
	PHYSICAL_HP,
}

signal stat_change
signal auto_study_level_changed

class Stat:
	var levels:int = 0
	var stat_name:String = "Coding"
	var id:int = 0
	var coding_spend_amount: int = 0
	var art_spend_amount: int = 0
	
	func _init( stat_name, id, coding_spend_amount = 0, art_spend_amount = 0):
		self.stat_name = stat_name
		self.id = id
		self.coding_spend_amount = coding_spend_amount
		self.art_spend_amount = art_spend_amount
	
	func can_add(free:bool = false):
		if free: return true
		if coding_spend_amount > Stats_Handler.unspent_coding_levels:
			return false
		if art_spend_amount > Stats_Handler.unspent_art_levels:
			return false
		
		return true
	
	func add(free:bool = false, amount:int = 1):
		levels += amount
		
		match id:
			LEVEL_STATS.CODING:
				Stats_Handler.unspent_coding_levels += amount
			LEVEL_STATS.ART:
				Stats_Handler.unspent_art_levels += amount
			LEVEL_STATS.AUTO_STUDY:
				Stats_Handler.auto_study_level += amount
				
		if free: return
		Stats_Handler.unspent_coding_levels -= coding_spend_amount
		Stats_Handler.unspent_art_levels    -= art_spend_amount

class Modifier_Stat:
	var value: float = 100.0
	var has_max: bool = false
	var max:float = 100.0
	var stat_name:String = "Energy"
	var id:MODIFIER_STATS = MODIFIER_STATS.ENERGY
	var optimal_range:Array = [] #only used for temperature
	var has_optimal_range: bool = false
	
	#when the value drops beneath the limit - the project progress is reduced by timesing the limit_effects
	var limits = [20, 30]
	var limit_effects = [0.5, 0.7]
	
	func _init(id:MODIFIER_STATS, stat_name:String, max:float = 100.0, limits:Array = [20,30], limit_effects = [0.5, 0.7], optimal_range:Array = []):
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


static var stats:Array[Stat] =[
	Stat.new(    "Coding", LEVEL_STATS.CODING          ),
	Stat.new(       "Art", LEVEL_STATS.ART             ),
	Stat.new("Auto Study", LEVEL_STATS.AUTO_STUDY, 1, 1),
	Stat.new(   "Web Dev", LEVEL_STATS.WEB_DEV,    1   ),
	Stat.new(  "Game Dev", LEVEL_STATS.GAME_DEV,   1   ),
	Stat.new(  "Dig. Art", LEVEL_STATS.DIG_ART,    0, 1),
	Stat.new( "Trad. Art", LEVEL_STATS.TRAD_ART,   0, 1),
]

static var modifier_stats:Array[Modifier_Stat] = [
	Modifier_Stat.new(MODIFIER_STATS.ENERGY, "Energy", 80.0),
	Modifier_Stat.new(MODIFIER_STATS.TEMPERATURE, "Temperature", 100.0, [], [], [30, 70]),
	Modifier_Stat.new(MODIFIER_STATS.COMFORT, "Comfort", 80.0),
	Modifier_Stat.new(MODIFIER_STATS.MENTAL_HP, "Mental HP", 80.0),
	Modifier_Stat.new(MODIFIER_STATS.PHYSICAL_HP, "Physical HP", 50.0)
]

func get_stat(stat_id: LEVEL_STATS):
	for stat:Stat in stats:
		if stat.id == stat_id:
			return stat
	return null

static func get_modifier_stat(stat_id: MODIFIER_STATS):
	for stat:Modifier_Stat in modifier_stats:
		if stat.id == stat_id:
			return stat
	return null
	
func can_add(stat_index:int, free:bool = false):
	var stat:Stat = get_stat(stat_index)
	return stat.can_add(free)
	
	
func increment_stat(stat_id:int, amount:int = 1, is_free:bool = false):
	if stat_id <2: is_free = true # id 0 = coding id 1 = art
	var stat:Stat = get_stat(stat_id)
	if not stat.can_add(is_free): return
	stat.add(is_free, amount)
	if stat.id == LEVEL_STATS.AUTO_STUDY:
		print("AUTO_STUDY LEVEL CHANGED ", auto_study_level)
		emit_signal("auto_study_level_changed", auto_study_level)
	emit_signal("stat_change", stat_id, stat.levels)


func get_enabled_add_stats():
	var enabled_stats_ids = []
	for stat:Stat in stats:
		if stat.id < 2: #coding and art never display add button
			continue
		if stat.can_add(): enabled_stats_ids.append(stat.id)
	
	return enabled_stats_ids
		
