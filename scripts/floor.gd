extends AnimatedSprite2D

@export var preview : bool = true
@export var redHighlight : bool = false
@export var typeAtPlacement : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$timer.start(1)
	speed_scale = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	handlePlacementPreview()
	
	if !preview:
		#Checks if the tile is hovered for deletion
		if redHighlight:
			modulate = Color(2, 0.5, 0.5, 1)
			if str(Global.mousePos0) != name or Global.tileMap.currentFloorAction != Enums.FLOORMODE.DELETING:
				redHighlight = false
		else:
			modulate = Color(1, 1, 1, 1)

func handlePlacementPreview():
	if preview:
		position = Global.floorLayer.map_to_local(Global.mousePos0) + Vector2(0, 4)
		modulate = Color(1.2, 1.2, 1.2, 0.9 - $timer.time_left / 2)
		visible = true
		if Global.tileMap.currentFloorAction != Enums.FLOORMODE.PLACING or Global.tileMap.floorTypeToBePlaced != typeAtPlacement or Global.currBuildShopTab != Enums.BUILDMODETAB.FLOOR:
			queue_free()
		if !Global.floorLayer.get_node(str(Global.mousePos0)):
			Input.set_custom_mouse_cursor(Global.placeCursor)
		elif Global.floorLayer.get_node(str(Global.mousePos0)).frame != self.frame:
			Input.set_custom_mouse_cursor(Global.paintCursor)
		else:
			Input.set_custom_mouse_cursor(Global.blockCursor)
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == false:
			if preview:
				if !Global.floorLayer.get_node(str(Global.mousePos0)) or Global.floorLayer.get_node(str(Global.mousePos0)).frame != self.frame:
					preview = false
					modulate = Color(1, 1, 1, 1)
					set_name(str(Global.mousePos0))
					Global.tileMap.hovering = false
		

func changeTexture(texture : int):
	set_frame_and_progress(texture, 0)


func _on_preview_timer_timeout() -> void:
	if preview:
		$timer.start(1)
