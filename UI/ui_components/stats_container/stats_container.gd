class_name Modifier_Stat_View extends HBoxContainer 

@export var id:Enums.MODIFIER_STATS = Enums.MODIFIER_STATS.ENERGY
@export var label:String = "Energy"
@export var tooltip:String = "<30% = x0.7, <20% = x0.5"
@onready var progress_bar = %ProgressBar
#@onready var data: Modifier_Stat = Stats_Handler.get_modifier_stat(id)

	
func _ready() -> void:
	$Label.text = label
	$Label.tooltip_text = tooltip
	#progress_bar.ready.connect(func(): progress_bar.value = data.value)
	#if progress_bar.is_node_ready():
	#	progress_bar.value = data.value
	
	
