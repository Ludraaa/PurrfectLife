extends TileMap

const floorTile = preload("res://scenes/floor_tile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	#initialize a small square floor, this will be loaded with every new game
	for cellPos in get_used_cells(0):
		var cellAtlasPos = get_cell_atlas_coords(0, cellPos)
		if cellAtlasPos == Vector2i(2, 4):
			var floor = floorTile.instantiate()
			floor.position = map_to_local(cellPos) * scale
			add_child(floor)
			erase_cell(0, cellPos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
