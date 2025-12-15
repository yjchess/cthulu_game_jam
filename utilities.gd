class_name Utilities extends Node

static func convert_enum_to_string(enum_name, enum_value):
	var stringified:String = enum_name.keys()[enum_value].capitalize()
	return stringified
