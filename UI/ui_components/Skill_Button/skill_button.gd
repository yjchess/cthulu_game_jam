extends TextureButton
@export var skill_name: String
@export var description: String
@export var project_point_cost: int
@export var has_max:bool = false
@export var max:int = 1
@onready var tooltip:Custom_ToolTip = %Custom_Tooltip

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%skill_name.text = skill_name
	tooltip.title = skill_name
	tooltip.main_content = description
	tooltip.extra_content = "Costs: "+str(project_point_cost)+" project points!"
	tooltip.update_content()
	
	if has_max:
		%skill_lvl.text += " / "+str(max)


func _on_mouse_entered() -> void:
	%Custom_Tooltip.show()




func _on_mouse_exited() -> void:
	%Custom_Tooltip.hide()
