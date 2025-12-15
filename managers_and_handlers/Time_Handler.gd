class_name Time_Handler extends Node

signal auto_study_tick
var auto_study_ticks_base: float = 5.5
@onready var auto_study_timer:Timer = %auto_study_timer
var auto_study_curve = preload("res://managers_and_handlers/Stats/auto_study_curve.tres")

signal second_passed
signal day_passed
signal season_passed
signal year_passed

var time:int = 8*60:
	set(v):
		time = v if v < 24*60 else 0; 
		if time == 0 and v % 24*60 == 0: day += 1 
		
var day:int = 1:
	set(v):
		day = v if v < 29 else 1
		emit_signal("day_passed", day)
		
		if day == 1:
			season += 1

var season:int = 1:
	set(v):
		season = v if v < 5 else 1
		emit_signal("season_passed", season)
		
		if season == 1:
			year += 1

var year:int = 1:
	set(v):
		year = v
		emit_signal("year_passed", year)
		
@onready var day_timer: Timer = %day_timer

func _ready():
	calculate_auto_study_wait_time(0)
	day_timer.timeout.connect(increment_time)

func increment_time():
	time += 24*60;
	
	var hours:int = time / 60
	var minutes:int = time % 60
	var formatted_hours = "0"+str(hours) if hours <10 else str(hours)
	var formatted_minutes = "0"+str(minutes) if minutes < 10 else str(minutes)
	var formatted_time = formatted_hours + "." + formatted_minutes
	emit_signal("second_passed", formatted_time)

func auto_study_level_changed(auto_study_level:int):
	if auto_study_level == 1:
		day_timer.start()
		auto_study_timer.start()
	else:
		calculate_auto_study_wait_time(auto_study_level)

func calculate_auto_study_wait_time(auto_study_level:int):
	var time_reduction_x:float = (auto_study_level -1) /200.0
	var time_reduction:float = auto_study_curve.sample_baked(time_reduction_x)
	
	auto_study_timer.timeout.connect(self.auto_study_tick.emit)
	auto_study_timer.wait_time = auto_study_ticks_base - time_reduction
	print(auto_study_timer.wait_time)
