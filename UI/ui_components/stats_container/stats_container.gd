@tool
extends HBoxContainer 

@export var id:Stats_Handler.MODIFIER_STATS = Stats_Handler.MODIFIER_STATS.ENERGY
@export var label:String = "Energy"
@onready var progress_bar = %ProgressBar
@onready var data:Stats_Handler.Modifier_Stat = Stats_Handler.get_modifier_stat(id)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = label
	progress_bar.value = data.value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
