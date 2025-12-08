class_name Game_Manager extends Node2D
var progress_handler: Progress_Handler = Progress_Handler.new()
var stat_handler: Stats_Handler = Stats_Handler.new()
@onready var time_handler: Time_Handler = %Time_Handler
@onready var ui_handler: UI_Handler = $UI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progress_handler.progress_bar = $UI/Score_Containers/StatsContainer/ProgressBar
	progress_handler.finished_progress.connect(progress_finished)
	stat_handler.stat_change.connect(stat_changed)
	stat_handler.auto_study_level_changed.connect(time_handler.auto_study_level_changed)
	ui_handler.skills_shop_view.connect(skills_shop_view)
	ui_handler.add_button_pressed.connect(stat_handler.increment_stat)
	ui_handler.project_selected.connect(ui_project_selected)
	time_handler.auto_study_tick.connect(progress_handler.player_click)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_keyboard_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	
	if (event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT):
		progress_handler.player_click()
	
func progress_finished():
	stat_handler.increment_stat(ui_handler.get_current_project())
	ui_handler.refresh_view()

func stat_changed(stat_index:int, stat_value:int):
	ui_handler.update_stat_view(stat_index, stat_value)

func skills_shop_view():
	var enabled_add_button_stats = stat_handler.get_enabled_add_stats()
	ui_handler.display_skills_shop_view(enabled_add_button_stats)

func ui_project_selected(project_id:int):
	progress_handler.change_project(project_id)
	
