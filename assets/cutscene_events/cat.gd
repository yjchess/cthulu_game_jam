@tool
extends Node2D
signal cat_petted


@export var marker_two:Marker2D:
	set(v):
		marker_two = v
		midway_position = marker_two.global_position



@onready var original_position:Vector2 = self.global_position
var midway_position:Vector2


func start_animation() -> void:
	show()

	await move_cat(midway_position, false)
	await move_cat(original_position, true)
	await move_cat(midway_position, false)
	await move_cat(original_position, true)

	hide()


func move_cat(target: Vector2, flip: bool) -> void:
	$AnimatedSprite2D.flip_h = flip
	var tween := create_tween()
	tween.tween_property(
		$AnimatedSprite2D,
		"global_position",
		target,
		3.0
	)
	await tween.finished
	


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT):
		emit_signal("cat_petted")
		hide()
