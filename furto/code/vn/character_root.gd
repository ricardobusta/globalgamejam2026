extends Control

class_name CharacterRoot

@export var char_name: String
@export var char_protag: bool

const off_distance = 1000
const on_distance = 500

func get_off_position() -> int:
	return -off_distance if char_protag else 1920+off_distance

func get_on_position() -> int:
	return on_distance if char_protag else (1920 - on_distance)
