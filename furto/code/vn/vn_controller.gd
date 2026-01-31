extends Node

class_name VNController

@onready var vn_text_panel : TextureRect = $"../VNCanvas/Root/TextPanel"
@onready var vn_text_label : RichTextLabel = $"../VNCanvas/Root/TextPanel/TextLabel"
@onready var vn_fade_panel : ColorRect = $"../VNCanvas/Root/FadePanel"
@onready var location_canvas : CanvasLayer = $"../LocationCanvas"
@onready var character_canvas: CanvasLayer = $"../CharacterCanvas"

const vn_text_panel_on_y: int = 780
const vn_text_panel_off_y: int = 1500
const vn_text_animate_duration: float = 0.4
const vn_text_animate_text_duration_per_char: float = 0.02

var location_node: LocationRoot

func _ready():
	vn_text_panel.visible = false
	vn_fade_panel.visible = false

func async_load_character(res: String) -> CharacterRoot:
	var packed_character := load(res)
	var c: CharacterRoot = packed_character.instantiate()
	c.name = c.char_name
	character_canvas.add_child(c)
	c.visible = false
	c.position.y = 1080
	return c

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
	
func async_show_text(text: String, character: CharacterRoot) -> void:
	await async_show_texts([text], character)
	
func async_show_texts(texts: Array[String], character: CharacterRoot) -> void:
	vn_text_panel.visible = true
	vn_text_panel.position = Vector2(0, vn_text_panel_off_y)
	vn_text_label.visible_ratio = 0.0
	
	var tween := create_tween()
	tween.tween_property(vn_text_panel, "position:y", vn_text_panel_on_y, vn_text_animate_duration)\
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	
	if character != null:
		character.position.x = character.get_off_position()
		character.visible = true
		tween.parallel().tween_property(character, "position:x", character.get_on_position(), vn_text_animate_duration)
	
	await tween.finished
	
	for text in texts:
		vn_text_label.visible_ratio = 0.0
		tween = create_tween()
		vn_text_label.text = text
		var text_duration = text.length() * vn_text_animate_text_duration_per_char
		tween.tween_property(vn_text_label, "visible_ratio", 1.0, text_duration)\
		.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
		await tween.finished
		await async_wait_for_click()
	
	tween = create_tween()
	tween.tween_property(vn_text_panel, "position:y", vn_text_panel_off_y, vn_text_animate_duration)\
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		
	if character != null:
		tween.parallel().tween_property(character, "position:x", character.get_off_position(), vn_text_animate_duration)
		
	await tween.finished
	
	if character != null:
		character.visible = false
	
	vn_text_panel.visible = false

func async_wait_for_click() -> void:
	while true:
		await get_tree().process_frame
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			return
