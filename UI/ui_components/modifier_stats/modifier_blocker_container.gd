extends HBoxContainer
@export var amount_blocked:float = 20.0

func _ready() -> void:
	%ProgressBar.value = amount_blocked-4
