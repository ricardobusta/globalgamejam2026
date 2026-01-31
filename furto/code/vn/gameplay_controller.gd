extends Node

@onready var vn_text_panel : TextureRect = $VNCanvas/Root/TextPanel
@onready var vn_text_label : RichTextLabel = $VNCanvas/Root/TextPanel/TextLabel
@onready var vn_fade_panel : ColorRect = $VNCanvas/Root/FadePanel
@onready var location_canvas : CanvasLayer = $LocationCanvas
@onready var character_canvas: CanvasLayer = $CharacterCanvas

@export var placeholder_location: String = "res://assets/locations/placeholder/placeholder_location.tscn"
@export var placeholder_character: String = "res://assets/characters/placeholder/placeholder_character.tscn"

var location_node: LocationRoot
const vn_text_panel_on_y: int = 780
const vn_text_panel_off_y: int = 1500
const vn_text_animate_duration: float = 0.4
const vn_text_animate_text_duration: float = 1.5

func _ready() -> void:
	var char1:= await async_load_character(placeholder_character)
	var char2:= await async_load_character(placeholder_character)
	
	await async_set_location(placeholder_location, 0.0)
	vn_text_panel.visible = false
	vn_fade_panel.visible = false
	await async_show_text("Lorem ipsum")
	await async_show_text("Testing something")
	await async_set_location(placeholder_character, 1.0)
	await async_show_text("a")
	await async_show_text("b")
	
func async_load_character(res: String) -> CharacterRoot:
	var packed_character := load(res)
	var char: CharacterRoot = packed_character.instantiate()
	char.name = char.char_name
	character_canvas.add_child(char)
	char.visible = false
	return char

func unload_all_characters():
	for child in character_canvas.get_children():
		child.queue_free()

func async_set_location(res: String, fade_duration: float) -> void:
	if fade_duration > 0 and location_node:
		vn_fade_panel.visible = true
		vn_fade_panel.color.a = 0
		var tween := create_tween()
		tween.tween_property(vn_fade_panel, "color:a", 1, fade_duration)\
			.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		await tween.finished
	
	for child in location_canvas.get_children():
		child.queue_free()
		
	var packed_scene := load(res)
	location_node = packed_scene.instantiate()
	location_canvas.add_child(location_node)
		
	if fade_duration > 0:
		var tween := create_tween()
		tween.tween_property(vn_fade_panel, "color:a", 0, fade_duration)\
			.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		await tween.finished
		vn_fade_panel.visible = false
	
	
func async_show_text(text: String) -> void:
	vn_text_panel.visible = true
	vn_text_panel.position = Vector2(0, vn_text_panel_off_y)
	vn_text_label.text = text
	vn_text_label.visible_ratio = 0.0
	
	var tween := create_tween()
	tween.tween_property(vn_text_panel, "position:y", vn_text_panel_on_y, vn_text_animate_duration)\
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(vn_text_label, "visible_ratio", 1.0, vn_text_animate_text_duration)\
		.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	
	await tween.finished
	await async_wait_for_click()
	
	tween = create_tween()
	tween.tween_property(vn_text_panel, "position:y", vn_text_panel_off_y, vn_text_animate_duration)\
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		
	await tween.finished
	
	vn_text_panel.visible = false

func async_wait_for_click() -> void:
	while true:
		await get_tree().process_frame
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			return
