extends CanvasLayer

class_name Cursor

@onready var main_cursor: AnimatedSprite2D = $Cursor

var is_blocked: bool = false

func _init() -> void:
	Engine.register_singleton(&"Cursor", self)


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Utils.gameplay_controller.ready.connect(show_cursor)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func show_cursor(anim_name: String = "normal", ignore_block: bool = false) -> void:
	if not ignore_block and is_blocked: return

	if (not anim_name.is_empty() and
		not main_cursor.sprite_frames.has_animation(anim_name)):
		printerr("Cursor has no animation: %s" % anim_name)
		return
