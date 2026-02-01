@tool

extends Node

class_name Utils

static var cursor: Cursor = null:
	get = get_cursor
static var gameplay_controller: GameplayController = null:
	get = get_gameplay_controller
static var inventory_controller: InventoryController = null:
	get = get_inventory_controller
#static var vn_controller: VNController = null:
	#get = get_vn_controller


static func get_cursor() -> Cursor:
	if not is_instance_valid(cursor):
		if Engine.get_singleton(&"C"):
			cursor = Engine.get_singleton(&"C")
		else:
			cursor = Cursor.new()
	return cursor


static func get_gameplay_controller() -> GameplayController:
	if not is_instance_valid(gameplay_controller):
		if Engine.get_singleton(&"GC"):
			gameplay_controller = Engine.get_singleton(&"GC")
		else:
			gameplay_controller = GameplayController.new()
	return gameplay_controller


static func get_inventory_controller() -> InventoryController:
	if not is_instance_valid(inventory_controller):
		if Engine.get_singleton(&"InventoryController"):
			inventory_controller = Engine.get_singleton(&"InventoryController")
		else:
			inventory_controller = InventoryController.new()

	return inventory_controller


#static func get_vn_controller() -> VNController:
	#if not is_instance_valid(vn_controller):
		#if Engine.get_singleton(&"VNC"):
			#vn_controller = Engine.get_singleton(&"VNC")
		#else:
			#vn_controller = VNController.new()
	#return vn_controller
