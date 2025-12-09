extends HBoxContainer
@export var amount_blocked:float = 20.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%ProgressBar.value = amount_blocked-4


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
