extends Node

@export var gameplay_scene: String = "res://scenes/gameplay.tscn"


@onready var start_button: Button = $Button


func _ready() -> void:
	start_button.pressed.connect(_on_start_button_clicked)
	
	
func _on_start_button_clicked() -> void:
	get_tree().change_scene_to_file(gameplay_scene)
