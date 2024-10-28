extends AnimatedSprite2D

@export var preview : bool = true
#var tileMap : Node2D 
#var floorLayer : TileMapLayer

var boundTileCoords

@export var redHighlight : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$timer.start(1)
	speed_scale = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	handlePlacementPreview()
	
	if !preview:
		#Checks for existence of base tile to delete
		if Global.floorLayer.get_cell_atlas_coords(boundTileCoords) != Vector2i(2, 4):
			queue_free()
			
		#Checks if the tile is hovered for deletion
		if redHighlight:
			modulate = Color(2, 0.5, 0.5, 1)
			if str(Global.mousePos0) != name:
				redHighlight = false
		else:
			modulate = Color(1, 1, 1, 1)

func handlePlacementPreview():
	if preview:
		position = Global.floorLayer.map_to_local(Global.mousePos0) + Vector2(0, 4)
		modulate = Color(1.2, 1.2, 1.2, 0.9 - $timer.time_left / 2)
		visible = true
		if Global.tileMap.currentAction != Enums.FLOORMODE.PLACING:
			queue_free()
		
		if Input.is_action_just_pressed("lmb"):
			if !Global.floorLayer.get_cell_tile_data(Global.mousePos0):
				preview = false
				modulate = Color(1, 1, 1, 1)
				Global.floorLayer.set_cell(Global.mousePos0, 0, Vector2i(2, 4))
				boundTileCoords = Global.mousePos0
				set_name(str(boundTileCoords))
				Global.tileMap.hovering = false
			elif Global.floorLayer.get_node(str(Global.mousePos0)).frame != self.frame:
				preview = false
				modulate = Color(1, 1, 1, 1)
				Global.floorLayer.set_cell(Global.mousePos0, 0, Vector2i(2, 4))
				boundTileCoords = Global.mousePos0
				set_name(str(boundTileCoords))
				Global.tileMap.hovering = false

func changeTexture(texture : int):
	set_frame_and_progress(texture, 0)


func _on_preview_timer_timeout() -> void:
	if preview:
		$timer.start(1)
