extends Node2D

@export var currentFloorAction : Enums.FLOORMODE = Enums.FLOORMODE.NONE

@export var hovering = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.tileMap = self
	Global.floorLayer = $Floor
	Global.layer1 = $Layer1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Global.mousePos0 = $Floor.local_to_map(Global.mousePos)
	
	#Spawns a floor tile at the mouse location that can be placed down by clicking lmb
	if Input.is_action_just_pressed("debug place floor"):
		if currentFloorAction != Enums.FLOORMODE.PLACING:
			print("Debug: Placing Tiles")
			currentFloorAction = Enums.FLOORMODE.PLACING
		else:
			currentFloorAction = Enums.FLOORMODE.NONE
			hovering = false
			Input.set_custom_mouse_cursor(Global.defaultCursor)
			print("Debug: no action")
		
	#Deletes the hovered floor tile
	if Input.is_action_just_pressed("debug delete floor"):
		if currentFloorAction != Enums.FLOORMODE.DELETING:
			print("Debug: Deleting Floor")
			hovering = false
			currentFloorAction = Enums.FLOORMODE.DELETING
		else:
			currentFloorAction = Enums.FLOORMODE.NONE
			print("Debug: no action")

	
	match(currentFloorAction):
		Enums.FLOORMODE.DELETING:
			if Global.floorLayer.get_node(str(Global.mousePos0)):
				Global.floorLayer.get_node(str(Global.mousePos0)).redHighlight = true
				Input.set_custom_mouse_cursor(Global.deleteCursor)
			else:
				Input.set_custom_mouse_cursor(Global.deletionCursor)
			if Input.is_action_just_pressed("lmb") and Global.floorLayer.get_node(str(Global.mousePos0)):
				Global.floorLayer.get_node(str(Global.mousePos0)).queue_free()
		Enums.FLOORMODE.PLACING:
			if !hovering:
				var floor = Global.floorTile.instantiate()
				floor.preview = true
				floor.changeTexture(1)
				floor.visible = false
				floor.get_node("timer").start(1)
				Global.floorLayer.add_child(floor)
				hovering = true
		Enums.FLOORMODE.NONE:
			Input.set_custom_mouse_cursor(Global.defaultCursor)
