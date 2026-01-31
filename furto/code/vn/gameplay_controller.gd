extends Node

@onready var vn_controller: VNController = $VNController
@export var placeholder_location: String = "res://assets/locations/placeholder/placeholder_location.tscn"

func _ready() -> void:
	var fursuit_maker:= vn_controller.load_character("res://assets/characters/fursuit_maker/fursuit_maker.tscn")
	var protagonist:= vn_controller.load_character("res://assets/characters/protagonist/protagonist.tscn")

	await vn_controller.set_location(placeholder_location, 0.0)
	await vn_controller.show_texts(["Toasty","massa"], protagonist)
	await vn_controller.show_text("Eae mano", fursuit_maker)
	await vn_controller.show_text("E todos viveram felizes para sempre", null)
	await vn_controller.set_location(placeholder_location, 1.0)
	await vn_controller.show_text("a", null)
	await vn_controller.show_text("b", null)
	
	var result = await vn_controller.show_options(["OptionA", "OptionB", "OptionC"])
	await vn_controller.show_text("Você escolheu {result}", null)
