@tool
class_name Modifier_Stat_View extends HBoxContainer 

@export var id:Enums.MODIFIER_STATS = Enums.MODIFIER_STATS.ENERGY
@export var label:String = "Energy":
	set(v): label = v; $Label.text = label
@export var tooltip:String = "<30% = x0.7, <20% = x0.5":
	set(v): tooltip = v; $Label.tooltip_text = tooltip

@export var main_content:String = "How much energy you have. Sleep / rest to gain more."
@onready var progress_bar = %ProgressBar

func _ready():
	%Custom_Tooltip.title = label
	%Custom_Tooltip.main_content = main_content
	%Custom_Tooltip.extra_content = tooltip
	%Custom_Tooltip.update_content()

func _on_mouse_entered() -> void:
	%Custom_Tooltip.show()

func _on_mouse_exited() -> void:
	%Custom_Tooltip.hide()
