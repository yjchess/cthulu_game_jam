extends Node2D
var progress_handler: Progress_Handler = Progress_Handler.new()
var stat_handler: Stats_Handler = Stats_Handler.new()
@onready var ui_handler: UI_Handler = $UI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progress_handler.progress_bar = $UI/Score_Containers/StatsContainer/ProgressBar
	progress_handler.finished_progress.connect(progress_finished)
	stat_handler.potential_stat_change.connect(potential_stat_changed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_keyboard_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	
	if (event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT):
		progress_handler.player_click()
	
func progress_finished():
	stat_handler.increment_stat(ui_handler.get_current_project())
	ui_handler.increment_stat_view(ui_handler.get_current_project())


func potential_stat_changed(stat_index):
	ui_handler.increment_stat_view(stat_index)
