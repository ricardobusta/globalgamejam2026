extends CanvasLayer

class_name Cursor

@export var is_pixel_perfect: bool = false
@onready var cursor: AnimatedSprite2D = $Cursor
var is_blocked: bool = false


func _init() -> void:
	Engine.register_singleton(&"C", self)


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Utils.gameplay_controller.ready.connect(show_cursor)


func _process(delta: float) -> void:
	var texture_size: Vector2 = (cursor.sprite_frames.get_frame_texture(
		cursor.animation,
		cursor.frame
	) as Texture2D).get_size()

	var mouse_position: Vector2 = cursor.get_global_mouse_position()

	if is_pixel_perfect:
		cursor.position = Vector2i(mouse_position)
	else:
		cursor.position = mouse_position

	if cursor.position.x < 1.0:
		cursor.position.x = 1.0
	elif cursor.position.x > Utils.gameplay_controller.width - 2.0:
		cursor.position.x = Utils.gameplay_controller.width - 2.0

	if cursor.position.y < 1.0:
		cursor.position.y = 1.0
	elif cursor.position.y > Utils.gameplay_controller.height - 2.0:
		cursor.position.y = Utils.gameplay_controller.height - 2.0


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
