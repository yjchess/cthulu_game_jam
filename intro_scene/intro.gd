extends Control
var waiting = true
var started_timer = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		
	while $"%text".visible_ratio < 1:
		await get_tree().create_timer(0.085).timeout
		$"%text".visible_characters += 1
	

	await get_tree().create_timer(2).timeout
	$"%text".hide()
		
	while $"%text2".visible_ratio < 1:
		await get_tree().create_timer(0.085).timeout
		$"%text2".visible_characters += 1
	
	await get_tree().create_timer(2).timeout
	$"%text2".hide()
	%Door.show()
	


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT):
		get_tree().change_scene_to_file("res://room.tscn")
