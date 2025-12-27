class_name Cutscene_Events_Handler extends Node

enum CUTSCENES{
	RUBBISH_BUILDUP,
	CAT,
	ASKING_FOR_HELP
}

enum REWARDS{
	
}

class Cutscene:
	var id:CUTSCENES
	var reward: Array
	var animation
	
	func _init():
		pass
