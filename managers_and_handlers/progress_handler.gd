class_name Progress_Handler extends Node2D
signal finished_progress
signal project_enabled

var current_project_id: Projects = Projects.STUDY_CODE

enum Projects{
	STUDY_CODE,
	STUDY_ART,
	HOBBY_SITE,
	HOBBY_GAME,
	WEBSITE,
	GAME,
}

class Project_Progress:
	var project_id:int = 0
	var project_progress:float = 0.0
	var enabled:bool = false
	var tooltip:String = ""
	var disabled_tooltip:String = ""
	signal project_enabled
	
	func _init(project_id = 0, tooltip:String = "", disabled_tooltip:String = "", enabled = false, project_progress = 0.0):
		self.tooltip = tooltip
		self.disabled_tooltip = disabled_tooltip
		self.project_id = project_id
		self.project_progress = project_progress
		self.enabled = enabled
	
	func enable():
		if enabled == true: return
		enabled = true
		emit_signal("project_enabled", project_id)

var progress: float = 0.0:
	set(v):
		progress = v
		var project:Project_Progress = get_project(current_project_id)
		project.project_progress = v
		progress_bar.value = v
		
var progress_bar:ProgressBar :
	set(v):
		progress_bar = v
		progress_bar.value_changed.connect(change_progress)

var progress_base_value: float = 5.5
var projects:Array[Project_Progress] = [
	Project_Progress.new(Projects.STUDY_CODE, "Gain 1 Coding Level upon completion", "", true),
	Project_Progress.new(Projects.STUDY_ART, "Gain 1 Art Level upon completion", "", true),
	Project_Progress.new(Projects.HOBBY_SITE, "Gain 1 project point upon completion", "To Unlock: Put 1 skill point in Web Dev"),
	Project_Progress.new(Projects.HOBBY_GAME, "Gain 1 project point upon completion", "To Unlock: Put 1 skill point in Game Dev"),
	Project_Progress.new(Projects.WEBSITE, "Gain 5 project points and £10 upon completion", "To Unlock: 5 pts in Web Dev & Trad. Art"),
	Project_Progress.new(Projects.GAME, "Gain 5 project points and £10 upon completion", "To Unlock: 5 pts in Game Dev & Dig. Art")
]

func player_click(modifier_stats:Array[Modifier_Stat]):
	var modification:float = get_modification(modifier_stats)
	progress_bar.value += progress_base_value * modification
	if progress_bar.value >= 100.0:
		progress_bar.value = 0
		emit_signal("finished_progress")
	

func get_modification(modifier_stats:Array[Modifier_Stat]):
	var energy = modifier_stats[Enums.MODIFIER_STATS.ENERGY].value
	var temperature = modifier_stats[Enums.MODIFIER_STATS.TEMPERATURE].value
	var comfort = modifier_stats[Enums.MODIFIER_STATS.COMFORT].value
	var mental_health = modifier_stats[Enums.MODIFIER_STATS.MENTAL_HP].value
	var physical_health = modifier_stats[Enums.MODIFIER_STATS.PHYSICAL_HP].value
	
	var modification:float = 1.00
	
	if energy < 20:
		modification *= 0.5
	elif energy < 30:
		modification *= 0.7
	
	if temperature < 30 || temperature > 70:
		modification *= 0.7
	
	if comfort < 20:
		modification *= 0.5
	elif comfort < 30:
		modification *= 0.7
	
	if mental_health < 20:
		modification *= 0.5
	elif mental_health < 30:
		modification *= 0.7
	
	if physical_health < 20:
		modification *= 0.5
	elif physical_health < 30:
		modification *= 0.7
	
	return modification

func change_progress(value):
	progress = value

func change_project(project_id:Projects):
	current_project_id = project_id
	var project = get_project(current_project_id)
	progress = project.project_progress
	

func get_project(project_id:Projects) -> Project_Progress:
	for project:Project_Progress in projects:
		if project.project_id == project_id:
			return project
	return null

func get_projects() -> Array[Project_Progress]:
	return projects

func check_project_unlocks(web_dev_level:int, game_dev_level:int, trad_art_level:int, dig_art_level:int):
	if web_dev_level > 0:
		get_project(Projects.HOBBY_SITE).enable()
	
	if web_dev_level >= 5 and trad_art_level >= 5:
		get_project(Projects.WEBSITE).enable()
	
	if game_dev_level > 0:
		get_project(Projects.HOBBY_GAME).enable()
	
	if game_dev_level >= 5 and dig_art_level >= 5:
		get_project(Projects.GAME).enable()
		

func _ready():
	for project:Project_Progress in projects:
		project.project_enabled.connect(func(project_id): emit_signal("project_enabled", project_id))
