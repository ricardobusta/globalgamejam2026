extends Control

class_name CharacterRoot

@export var char_name: String
@export var char_protag: bool

func get_off_position() -> int:
	return -1000 if char_protag else 1920+1000

func get_on_position() -> int:
	return 300 if char_protag else (1920 - 300)
