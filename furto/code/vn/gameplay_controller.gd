extends Node

class_name GameplayController

@onready var vn_controller: VNController = $VNController
@export var placeholder_background_investigation_location: String = "res://assets/locations/placeholder_background_investigation/placeholder_background_investigation_location.tscn"
var clicked: ClickableRoot = null

func _init() -> void:
	Engine.register_singleton(&"GameplayController", self)


func _ready() -> void:
	await _act_1()
	await _act_2()

	#await vn_controller.set_location(placeholder_location, 0.0)
	#await vn_controller.show_texts(["Toasty","massa"], protagonist)
	#await vn_controller.show_text("Eae mano", fursuit_maker)
	#
	#while true:
		#var result = await vn_controller.show_options(["Macaco", "Vibes", "Layout"])
		#match result:
			#0:
				#await vn_controller.show_text("É, não, é?", protagonist)
			#1:
				#await vn_controller.show_text("Eae mano", fursuit_maker)
			#2:
				#await vn_controller.show_text("Design", null)
		#if result == 2:
			#break
	#
	#await vn_controller.show_text("E todos viveram felizes para sempre", null)
	#await vn_controller.set_location(placeholder_background_investigation_location, 1.0)
	#await vn_controller.show_text("a", null)
	#await vn_controller.show_text("b", null)
	# Something something with [color=#0000ff]color[/color]

func _act_1() -> void:
	var fursuit_maker:= vn_controller.load_character("res://assets/characters/fursuit_maker/fursuit_maker.tscn")
	var protagonist:= vn_controller.load_character("res://assets/characters/protagonist/protagonist.tscn")
	var placeholder_location:= "res://assets/locations/placeholder/placeholder_location.tscn"

	await vn_controller.set_location(placeholder_location, 0.0)
	
	await vn_controller.show_texts([
		"The opening day.",
		"Such a chaotic day for the staff.",
		"But it’s worth it."
		])
	
	await vn_controller.set_location(placeholder_location, 1.0)
	
	await vn_controller.show_texts([
		"This ain’t my first rodeo as a furry conference volunteer, but it’s my first one here.",
		"Wanted to help out a friend organizing, ended up being dragged here. At least my room was covered."
		])
	
	await vn_controller.set_location(placeholder_location, 1.0)
	
	await vn_controller.show_texts([
		"TIn just a couple hours, the opening ceremony will take place at the stage. Hundreds of furries from many different places coming together to have a good weekend.",
		"That’s one of the reasons why i do this. You don’t get much recognition, but it’s nice seeing everyone smile and laugh, just like in my first cons.",
		"In the meantime, gotta make sure everything is in order.",
		"I check in with some of our guests of honor. We got a good cast this year, gotta admit.",
		"Rocket Rangoon, WildPause...",
		"And the two i don’t really know too much about.",
		"[color=red]Alice Foxsnout[/color] and [color=#f00]Emma Panther[/color]."
		])
	
	vn_controller.unload_all_characters()
	
func _act_2() -> void:
	pass
