class_name Levellable_Stat extends Node

var levels:int = 0
var stat_name:String = "Coding"
var id:int = 0
var coding_spend_amount: int = 0
var art_spend_amount: int = 0
var stats_data: Stats_Data

func _init( stats_data:Stats_Data, stat_name:String, id:int, coding_spend_amount = 0, art_spend_amount = 0):
	self.stats_data = stats_data
	self.stat_name = stat_name
	self.id = id
	self.coding_spend_amount = coding_spend_amount
	self.art_spend_amount = art_spend_amount

func can_add(free:bool = false):
	if free: return true
	if coding_spend_amount > stats_data.unspent_coding_levels:
		return false
	if art_spend_amount > stats_data.unspent_art_levels:
		return false
	
	return true

func add(free:bool = false, amount:int = 1):
	levels += amount
	
	match id:
		Enums.LEVEL_STATS.CODING:
			stats_data.unspent_coding_levels += amount
		Enums.LEVEL_STATS.ART:
			stats_data.unspent_art_levels += amount
		Enums.LEVEL_STATS.AUTO_STUDY:
			stats_data.auto_study_level += amount
			
	if free: return
	stats_data.unspent_coding_levels -= coding_spend_amount
	stats_data.unspent_art_levels    -= art_spend_amount
