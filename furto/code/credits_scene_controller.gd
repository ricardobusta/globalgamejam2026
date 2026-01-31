extends Control

@export var title_scene: String = "res://scenes/title.tscn"

@onready var back_button: Button = $BackButton

func _ready() -> void:
	back_button.pressed.connect(_on_back_button_clicked)
	
func _on_back_button_clicked() -> void:
	get_tree().change_scene_to_file(title_scene)
