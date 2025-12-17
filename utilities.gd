class_name Utilities extends Node

static func convert_enum_to_string(enum_name, enum_value) -> String:
	for key in enum_name.keys():
		if enum_value == enum_name[key]:
			var stringified:String = key.capitalize()
			return stringified
	return ""

static func get_path_component_from_enum(enum_name, enum_value)-> String:
	var path = convert_enum_to_string(enum_name, enum_value)
	path = path.replace(" ", "_")
	path = path.to_lower()
	return path
