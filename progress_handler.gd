class_name Progress_Handler extends Node2D
signal finished_progress

var current_project_id: Projects = Projects.STUDY_CODE

enum Room_Projects{
	STUDY_CODE,
	STUDY_ART
}

enum Projects{
	STUDY_CODE,
	STUDY_ART
}

class Project_Progress:
	var project_id:int = 0
	var project_progress:float = 0.0
	
	func _init(project_id = 0, project_progress = 0.0):
		self.project_id = project_id
		self.project_progress = project_progress

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
var projects:Array = [
	Project_Progress.new(Projects.STUDY_CODE),
	Project_Progress.new(Projects.STUDY_ART)
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
