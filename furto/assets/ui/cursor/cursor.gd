class_name Cursor
extends CanvasLayer

@onready var cursor: AnimatedSprite2D = $Cursor
@onready var vn_controller: VNController = get_tree().root.find_child("VNController", true, false)

var is_blocked: bool = false


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Utils.gameplay_controller.ready.connect(show_cursor)


func _process(_delta: float) -> void:
	var mouse_position: Vector2 = cursor.get_global_mouse_position()

	cursor.position = mouse_position

	if cursor.position.x < 1.0:
		cursor.position.x = 1.0
	elif cursor.position.x > vn_controller.width - 2.0:
		cursor.position.x = vn_controller.width - 2.0

	if cursor.position.y < 1.0:
		cursor.position.y = 1.0
	elif cursor.position.y > vn_controller.height - 2.0:
		cursor.position.y = vn_controller.height - 2.0


func show_cursor(anim_name: String = "default", ignore_block: bool = false) -> void:
	if not ignore_block and is_blocked: return

	if (
		not anim_name.is_empty() and
		not cursor.sprite_frames.has_animation(anim_name)
	):
		printerr("Cursor has no animation: %s" % anim_name)
		return

	cursor.play(anim_name)
	cursor.show()
