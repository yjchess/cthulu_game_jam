@tool
extends HBoxContainer
@export var amount_blocked:float = 20.0:
	set(v): 
		amount_blocked = v
		%ProgressBar.value = amount_blocked-4
