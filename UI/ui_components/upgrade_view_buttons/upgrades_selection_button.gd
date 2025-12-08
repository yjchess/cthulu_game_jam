@tool
class_name Radio_Buttons extends Button

@export var button_text:String = "Skills"
@export var id:int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = button_text
	button_group = preload("res://UI/ui_components/upgrade_view_buttons/button_groups/upgrade_view_radio_buttons.tres")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
