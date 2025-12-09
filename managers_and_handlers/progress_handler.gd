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
	signal project_enabled
	
	func _init(project_id = 0, enabled = false, project_progress = 0.0):
		self.project_id = project_id
		self.project_progress = project_progress
		self.enabled = enabled
	
	func enable():
		if enabled == true: return
		enabled = true
		emit_signal("project_enabled", project_id)

var progress: float = 0.0:
	set(v):
		print("CHANGING PROGRESS TO: ", v)
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
	Project_Progress.new(Projects.STUDY_CODE, true),
	Project_Progress.new(Projects.STUDY_ART, true),
	Project_Progress.new(Projects.HOBBY_SITE),
	Project_Progress.new(Projects.HOBBY_GAME),
	Project_Progress.new(Projects.WEBSITE),
	Project_Progress.new(Projects.GAME)
]

func player_click():
	if not is_modification_needed():
		progress_bar.value += progress_base_value
		if progress_bar.value >= 100.0:
			progress_bar.value = 0
			emit_signal("finished_progress")
	pass
	

func is_modification_needed():
	return false

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
