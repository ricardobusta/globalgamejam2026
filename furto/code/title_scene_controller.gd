extends Control

@export var gameplay_scene: String = "res://scenes/gameplay.tscn"
@export var credits_scene: String = "res://scenes/credits.tscn"

@onready var play_button: Button = $PlayButton
@onready var credits_button: Button = $CreditsButton


func _ready() -> void:
	play_button.pressed.connect(_on_play_button_clicked)
	credits_button.pressed.connect(_on_credits_button_clicked)
	
	
func _on_play_button_clicked() -> void:
	get_tree().change_scene_to_file(gameplay_scene)

func _on_credits_button_clicked() -> void:
	get_tree().change_scene_to_file(credits_scene)
