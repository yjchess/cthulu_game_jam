@tool
class_name Radio_Buttons extends Button

@export var button_text:String = "Skills"
@export var id:int = 0
@export var button_group_of:button_groups = button_groups.UPGRADE_SELECTION

enum button_groups{
	UPGRADE_SELECTION,
	UPGRADE_AREA_SELECTION
}

func _ready() -> void:
	text = button_text
	match button_group_of:
		button_groups.UPGRADE_SELECTION:
			button_group = preload ("res://UI/ui_components/upgrade_view_buttons/button_groups/upgrade_selection.tres")
		button_groups.UPGRADE_AREA_SELECTION:
			button_group = preload("res://UI/ui_components/upgrade_view_buttons/button_groups/upgrade_area_selection.tres")
