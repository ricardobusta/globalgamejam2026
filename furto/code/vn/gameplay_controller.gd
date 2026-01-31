extends Node

class_name GameplayController

@onready var vn_controller: VNController = $VNController
@export var placeholder_location: String = "res://assets/locations/placeholder/placeholder_location.tscn"
@export var placeholder_background_investigation_location: String = "res://assets/locations/placeholder_background_investigation/placeholder_background_investigation_location.tscn"
var clicked: ClickableRoot = null

func _init() -> void:
	Engine.register_singleton(&"GameplayController", self)


func _ready() -> void:
	var fursuit_maker:= vn_controller.load_character("res://assets/characters/fursuit_maker/fursuit_maker.tscn")
	var protagonist:= vn_controller.load_character("res://assets/characters/protagonist/protagonist.tscn")

	await vn_controller.set_location(placeholder_location, 0.0)
	await vn_controller.show_texts(["Toasty","massa"], protagonist)
	await vn_controller.show_text("Eae mano", fursuit_maker)
	
	while true:
		var result = await vn_controller.show_options(["Macaco", "Vibes", "Layout"])
		match result:
			0:
				await vn_controller.show_text("É, não, é?", protagonist)
			1:
				await vn_controller.show_text("Eae mano", fursuit_maker)
			2:
				await vn_controller.show_text("Design", null)
		if result == 2:
			break
	
	await vn_controller.show_text("E todos viveram felizes para sempre", null)
	await vn_controller.set_location(placeholder_background_investigation_location, 1.0)
	#await vn_controller.show_text("a", null)
	#await vn_controller.show_text("b", null)
