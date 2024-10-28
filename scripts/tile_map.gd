extends Node2D

#var floorPlaceholder = Vector2i(2, 4)
@export var currentAction : Enums.FLOORMODE = Enums.FLOORMODE.NONE
#var mousePos
#var mouseTile0
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
		if currentAction != Enums.FLOORMODE.PLACING:
			print("Debug: Placing Tiles")
			currentAction = Enums.FLOORMODE.PLACING
		else:
			currentAction = Enums.FLOORMODE.NONE
			hovering = false
			print("Debug: no action")
		
	#Deletes the hovered floor tile
	if Input.is_action_just_pressed("debug delete floor"):
		if currentAction != Enums.FLOORMODE.DELETING:
			print("Debug: Deleting Floor")
			hovering = false
			currentAction = Enums.FLOORMODE.DELETING
		else:
			currentAction = Enums.FLOORMODE.NONE
			print("Debug: no action")

	
	match(currentAction):
		Enums.FLOORMODE.DELETING:
			if Global.floorLayer.get_node(str(Global.mousePos0)):
				Global.floorLayer.get_node(str(Global.mousePos0)).redHighlight = true
			if Input.is_action_just_pressed("lmb"):
				Global.floorLayer.erase_cell(Global.mousePos0)
		Enums.FLOORMODE.PLACING:
			if !hovering:
				var floor = Global.floorTile.instantiate()
				floor.preview = true
				floor.changeTexture(1)
				floor.visible = false
				floor.get_node("timer").start(1)
				Global.floorLayer.add_child(floor)
				hovering = true
