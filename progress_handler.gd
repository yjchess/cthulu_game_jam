class_name Progress_Handler extends Node2D
signal finished_progress


var progress: float = 0.0:
	set(v):
		progress = v
		print(progress)
		
var progress_bar:ProgressBar :
	set(v):
		progress_bar = v
		progress_bar.value_changed.connect(change_progress)

var progress_base_value: float = 5.5

func player_click():
	if not is_modification_needed():
		progress_bar.value += progress_base_value
		if progress_bar.value >= 100.0:
			progress_bar.value = 0
			emit_signal("finished_progress")
	pass
	

func is_modification_needed():
	return false

func change_progress():
	progress = progress_bar.value
