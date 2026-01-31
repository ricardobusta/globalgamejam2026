extends Node

class_name InventoryController

signal item_selected(item: InventoryItemRoot)

var active: InventoryItemRoot : set = set_active

func _init() -> void:
	Engine.register_singleton(&"InventoryController", self)


func set_active(value: InventoryItemRoot) -> void:
	if is_instance_valid(active):
		active.unselected.emit()

	active = value
	item_selected.emit(active)
