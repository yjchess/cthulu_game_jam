class_name Stats_Handler extends Node

static var unspent_coding_levels: int = 0
static var unspent_art_levels: int = 0

static var levels:Dictionary = {
	LEVEL_STATS.CODING : 0,
	LEVEL_STATS.ART: 0,
	LEVEL_STATS.AUTO_STUDY: 0
}

enum LEVEL_STATS{
	CODING,
	ART,
	AUTO_STUDY
}

signal potential_stat_change

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
	
	func can_add():
		if coding_spend_amount < Stats_Handler.unspent_coding_levels:
			return false
		if art_spend_amount < Stats_Handler.unspent_art_levels:
			return false
		
		return true

var stats:Array[Stat] =[
	Stat.new("Coding", LEVEL_STATS.CODING),
	Stat.new("Art", LEVEL_STATS.ART),
	Stat.new("Auto_Study", LEVEL_STATS.AUTO_STUDY, 1, 1)
]

func can_add(stat_index:int, free:bool = false):
	if free: return true
	
	match stat_index:
		LEVEL_STATS.CODING:
			return true
		LEVEL_STATS.ART:
			return true
		LEVEL_STATS.AUTO_STUDY:
			if unspent_art_levels > 0 and unspent_coding_levels > 0:
				return true
				
	pass
	
func increment_stat(stat:int, amount:int = 1, free:bool = false):
	levels[stat] += amount
	print(levels[stat])
	
	match stat:
		LEVEL_STATS.CODING:
			unspent_coding_levels += amount
		LEVEL_STATS.ART:
			unspent_art_levels += amount
		LEVEL_STATS.AUTO_STUDY:
			if not free:
				unspent_coding_levels -= 1
				unspent_art_levels -= 1
			levels.LEVEL_STATS.AUTO_STUDY += amount
				
	emit_signal("potential_stat_change", stat)
