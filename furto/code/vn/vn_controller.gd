extends Node

class_name VNController

@onready var vn_root: VNRoot = $"../VNCanvas"
@onready var location_canvas : CanvasLayer = $"../LocationCanvas"
@onready var character_canvas: CanvasLayer = $"../CharacterCanvas"

const vn_text_panel_on_y: int = 780
const vn_text_panel_off_y: int = 1500
const vn_text_animate_duration: float = 0.4
const vn_text_animate_text_duration_per_char: float = 0.02

var location_node: LocationRoot
var option_buttons: Array[Button] = []
var option_selected_index: int

func _init() -> void:
	Engine.register_singleton(&"VNController", self)


func _ready():
	vn_root.init()
	vn_root.vn_text_panel.visible = false
	vn_root.vn_fade_panel.visible = false
	vn_root.vn_options_template_button.visible = false
	option_buttons.append(vn_root.vn_options_template_button)
	vn_root.vn_options_template_button.pressed.connect(_on_options_button_pressed.bind(0))
	for i in range(4):
		var button:= vn_root.vn_options_template_button.duplicate()
		vn_root.vn_options_layout.add_child(button)
		option_buttons.append(button)
		button.pressed.connect(_on_options_button_pressed.bind(i+1))


func load_character(res: String) -> CharacterRoot:
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


func set_location(res: String, fade_duration: float) -> void:
	if fade_duration > 0 and location_node:
		vn_root.vn_fade_panel.visible = true
		vn_root.vn_fade_panel.color.a = 0
		var tween := create_tween()
		tween.tween_property(vn_root.vn_fade_panel, "color:a", 1, fade_duration)\
			.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		await tween.finished
	
	for child in location_canvas.get_children():
		child.queue_free()
		
	var packed_scene := load(res)
	location_node = packed_scene.instantiate()
	location_canvas.add_child(location_node)
		
	if fade_duration > 0:
		var tween := create_tween()
		tween.tween_property(vn_root.vn_fade_panel, "color:a", 0, fade_duration)\
			.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		await tween.finished
		vn_root.vn_fade_panel.visible = false
	
	
func show_text(text: String, options: Dictionary = {}) -> void:
	await show_texts([text], options)
	
	
func show_texts(texts: Array[String], options: Dictionary = {}) -> void:
	var character: CharacterRoot = options.get("character", null)
	var name_override: String = options.get("name_override", "")
	var text_speed: float = 1.0 / options.get("text_speed", 1.0)
	var is_thought: bool = options.get("thinking", false)
	
	vn_root.vn_text_panel.visible = true
	vn_root.vn_text_panel.position.y = vn_text_panel_off_y
	vn_root.vn_text_label.visible_ratio = 0.0
	
	if name_override.is_empty():
		if character != null:
			vn_root.vn_name_label.visible = true
			vn_root.vn_name_label.position.x = character.get_on_position() - vn_root.vn_name_label.size.x/2.0
			vn_root.vn_name_label.text = character.char_name
		else:
			vn_root.vn_name_label.visible = false
	else:
		vn_root.vn_name_label.visible = true
		vn_root.vn_name_label.position.x = 1920/2.0 - vn_root.vn_name_label.size.x/2.0
		vn_root.vn_name_label.text = name_override
	
	var tween := create_tween()
	tween.tween_property(vn_root.vn_text_panel, "position:y", vn_text_panel_on_y, vn_text_animate_duration)\
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	
	if character != null:
		character.position.x = character.get_off_position()
		character.visible = true
		tween.parallel().tween_property(character, "position:x", character.get_on_position(), vn_text_animate_duration)
	
	await tween.finished
	
	for text in texts:
		vn_root.vn_text_label.visible_ratio = 0.0
		tween = create_tween()
		vn_root.vn_text_label.text = "[color=#09f]%s[/color]" % text if is_thought else text
		var text_duration = text.length() * vn_text_animate_text_duration_per_char
		tween.tween_property(vn_root.vn_text_label, "visible_ratio", 1.0, text_duration * text_speed)\
		.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
		await wait_for_click_or_tween(tween)
		vn_root.vn_text_label.visible_ratio = 1.0
		await get_tree().process_frame
		await wait_for_click()
		await get_tree().process_frame
	
	tween = create_tween()
	tween.tween_property(vn_root.vn_text_panel, "position:y", vn_text_panel_off_y, vn_text_animate_duration)\
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		
	if character != null:
		tween.parallel().tween_property(character, "position:x", character.get_off_position(), vn_text_animate_duration)
		
	await tween.finished
	
	if character != null:
		character.visible = false
	
	vn_root.vn_text_panel.visible = false


func wait_for_click_or_tween(tween: Tween) -> void:
	while true:
		await get_tree().process_frame
		if !tween.is_running():
			return;
		if Input.is_action_just_pressed("click"):
			tween.kill()
			return
		if Input.is_action_just_pressed("ui_accept"):
			tween.kill()
			return

func wait_for_click() -> void:
	while true:
		await get_tree().process_frame
		if Input.is_action_just_pressed("click"):
			return
		if Input.is_action_just_pressed("ui_accept"):
			return


func show_options(options: Array[String]) -> int:
	for i in range(len(option_buttons)):
		var button = option_buttons[i]
		if i < len(options):
			button.visible = true
			button.text = options[i]
		else:
			button.visible = false

	option_buttons[0].grab_focus()

	option_selected_index = -1
	while option_selected_index == -1:
		await get_tree().process_frame
		
	for i in range(len(option_buttons)):
		var button = option_buttons[i]
		button.visible = false
	
	return option_selected_index

func fade_screen(alpha: float, time: float) -> void:
	if time > 0:
		vn_root.vn_fade_panel.visible = true
		var tween := create_tween()
		tween.tween_property(vn_root.vn_fade_panel, "color:a", alpha, time)\
			.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		await tween.finished
		if alpha==0.0:
			vn_root.vn_fade_panel.visible = false	

func _on_options_button_pressed(index: int) -> void:
	option_selected_index = index
