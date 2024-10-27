extends Node2D

@onready var floorTile = preload("res://scenes/floor.tscn")
@onready var floorLayer = $Floor
@onready var layer1 = $Layer1
var floorPlaceholder = Vector2i(2, 4)
@export var currentAction = ""
var mousePos
var mouseTile0
@export var hovering = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Handle basic debug inputs
	mousePos = get_global_mouse_position()
	mouseTile0 = floorLayer.local_to_map(mousePos)
	
	#Spawns a floor tile at the mouse location that can be placed down by clicking lmb
	if Input.is_action_just_pressed("debug place floor"):
		if currentAction != "placing_floor":
			print("Debug: Placing Tiles")
			currentAction = "placing_floor"
		else:
			currentAction = ""
			hovering = false
			print("Debug: no action")
		
	#Deletes the hovered floor tile
	if Input.is_action_just_pressed("debug delete floor"):
		if currentAction != "deleting_floor":
			print("Debug: Deleting Floor")
			hovering = false
			currentAction = "deleting_floor"
		else:
			currentAction = ""
			print("Debug: no action")

	
	match(currentAction):
		"deleting_floor":
			if floorLayer.get_node(str(mouseTile0)):
				floorLayer.get_node(str(mouseTile0)).redHighlight = true
			if Input.is_action_just_pressed("lmb"):
				floorLayer.erase_cell(mouseTile0)
		"placing_floor":
			if !hovering:
				var floor = floorTile.instantiate()
				floor.preview = true
				floor.changeTexture(1)
				floor.visible = false
				floor.get_node("timer").start(1)
				floorLayer.add_child(floor)
				hovering = true
