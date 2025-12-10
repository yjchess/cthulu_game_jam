class_name Stats_Data extends Node

signal auto_study_level_changed(level:int)

var unspent_coding_levels:  int = 0
var unspent_art_levels:     int = 0
var project_points:         int = 0
var benefits_per_day: float = 15.00
var money:             float = 0.00


var auto_study_level:       int = 0:
	set(v):
		auto_study_level = v
		emit_signal("auto_study_level_changed", auto_study_level)
