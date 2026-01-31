extends Node

@onready var vn_text_panel : TextureRect = $VNCanvas/Root/Panel
@onready var vn_text_label : RichTextLabel = $VNCanvas/Root/Panel/RichTextLabel
@onready var location_canvas : CanvasLayer = $LocationCanvas

@export var location_packed : PackedScene = preload("res://assets/locations/placeholder/placeholder_location.tscn")


func _ready() -> void:
	location_canvas.add_child(location_packed.instantiate())
	vn_text_panel.visible = false
	await show_text("Lorem ipsum")
	await show_text("Testing something")

func show_text(text: String) -> void:
	vn_text_panel.visible = true
	vn_text_panel.scale = Vector2(1, 0)
	
	vn_text_label.text = text
	vn_text_label.visible_ratio = 0.0
	
	var duration = 1
	
	var tween := create_tween()
	tween.tween_property(vn_text_panel, "scale", Vector2.ONE, duration/2.0)\
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(vn_text_label, "visible_ratio", 1.0, duration)\
		.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	
	await tween.finished
	
	await wait_for_click()
	
	vn_text_panel.visible = false

func wait_for_click() -> void:
	while true:
		await get_tree().process_frame
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			return
