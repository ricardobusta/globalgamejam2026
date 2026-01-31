extends Area2D

class_name ClickableRoot

@export var clickable : bool = true: set = set_clickable

@onready var vn_controller: VNController = $"../../../VNController"

var last_clicked_button: int = -1
var times_clicked: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_event.connect(_on_click)

func disable() -> void:
	visible = false
	clickable = false

	await get_tree().process_frame


func enable() -> void:
	visible = true
	clickable = true

	await get_tree().process_frame


func is_enabled() -> bool:
	return visible and clickable and input_pickable


func enable_clickable() -> void:
	clickable = true
	input_pickable = true


func disable_clickable() -> void:
	clickable = false
	input_pickable = false


func _on_click() -> void:
	print("clicou no gato")
	await vn_controller.show_text("30 pão 1 real")


func on_item_used(item: InventoryItemRoot) -> void:
	await vn_controller.show_text("Isto é uma coisa.")
	Utils.inventory_controller.active = null


func set_clickable(value: bool) -> void:
	clickable = value


func _on_input_event(_viewport: Node, event: InputEventMouseButton, _shape_idx: int):
	if not event.pressed: return

	Utils.gameplay_controller.clicked = self
	var last_clicked_button : int = event.button_index

	get_viewport().set_input_as_handled()

	match last_clicked_button:
		MOUSE_BUTTON_LEFT, 0:
			if Utils.inventory_controller.active:
				await on_item_used(Utils.inventory_controller.active)
				times_clicked += 1

	Utils.gameplay_controller.clicked = null


func toggle_input() -> void:
	if clickable:
		input_pickable = visible
