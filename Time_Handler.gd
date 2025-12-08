class_name Time_Handler extends Node

signal auto_study_tick
var auto_study_ticks_base: float = 5.5
@onready var auto_study_timer:Timer = %auto_study_timer
var auto_study_curve:Curve = preload("res://auto_study_curve.tres")

func _ready():
	calculate_auto_study_wait_time()
	

func _process(delta: float) -> void:
	pass

func auto_study_level_changed(level):
	print("HELLO")
	if Stats_Handler.auto_study_level == 1:
		auto_study_timer.start()
		print("HELLO1")
	else:
		calculate_auto_study_wait_time()
		print("HELLO2")

func calculate_auto_study_wait_time():
	var time_reduction_x:float = (Stats_Handler.auto_study_level -1) /200.0
	var time_reduction:float = auto_study_curve.sample_baked(time_reduction_x)
	
	auto_study_timer.timeout.connect(self.auto_study_tick.emit)
	auto_study_timer.wait_time = auto_study_ticks_base - time_reduction
	print(auto_study_timer.wait_time)
