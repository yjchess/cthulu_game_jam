class_name Time_Handler extends Node

signal auto_study_tick
var auto_study_ticks_base: float = 5.5
@onready var auto_study_timer:Timer = %auto_study_timer
var auto_study_curve = preload("res://managers_and_handlers/Stats/auto_study_curve.tres")

signal second_passed
var time:int = 8*60
var day:int = 0
@onready var day_timer: Timer = %day_timer

func _ready():
	calculate_auto_study_wait_time(0)
	day_timer.timeout.connect(increment_time)

func increment_time():
	time += 1;
	if time >= 24*60:
		day += 1
		time = 1
	
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
