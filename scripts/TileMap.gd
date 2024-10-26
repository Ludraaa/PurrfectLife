extends TileMap

const floorTile = preload("res://scenes/floor_tile.tscn")
const wallTile = preload("res://scenes/wall_tile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	#initialize a small square floor, this will be loaded with every new game
	for cellPos in get_used_cells(0):
		var cellAtlasPos = get_cell_atlas_coords(0, cellPos)
		if cellAtlasPos == Vector2i(2, 4):
			var floor = floorTile.instantiate()
			floor.position = map_to_local(cellPos) * scale
			add_child(floor)
			#generates adjacent walls for the floor tile
			#erase_cell(0, cellPos)
	generate_walls()
	
	
	
func generate_walls():
	for cellPos in get_used_cells(0):
		if !get_cell_tile_data(0, cellPos - Vector2i(1, 0)):
			for layer in range(1, get_layers_count()):
				if !(get_cell_tile_data(layer, cellPos - Vector2i(1,0))):
					set_cell(layer, cellPos - Vector2i(1,0), 1, Vector2i(3, 2))
		if !get_cell_tile_data(0, cellPos - Vector2i(0, 1)):
			for layer in range(1, get_layers_count()):
				if !(get_cell_tile_data(layer, cellPos - Vector2i(0,1))):
					set_cell(layer, cellPos - Vector2i(0,1), 1, Vector2i(4, 2))
		if !get_cell_tile_data(0, cellPos + Vector2i(1, 0)):
			for layer in range(1, get_layers_count()):
				if !(get_cell_tile_data(layer, cellPos + Vector2i(1,0))):
					set_cell(layer, cellPos + Vector2i(1,0), 1, Vector2i(3, 3))
		if !get_cell_tile_data(0, cellPos + Vector2i(0, 1)):
			for layer in range(1, get_layers_count()):
				if !(get_cell_tile_data(layer, cellPos + Vector2i(0,1))):
					set_cell(layer, cellPos + Vector2i(0,1), 1, Vector2i(4, 3))
	
	for layer in range(1, get_layers_count()):
		for cellPos in get_used_cells(layer):
			if get_cell_atlas_coords(layer, cellPos) == Vector2i(3, 2) and get_cell_source_id(layer, cellPos) == 1:
				var wall_L = wallTile.instantiate()
				wall_L.position = map_to_local(cellPos) * scale + Vector2(12, 22) + Vector2(0, -40) * layer
				wall_L.z_index = layer
				add_child(wall_L)
				erase_cell(layer, cellPos)
			if get_cell_atlas_coords(layer, cellPos) == Vector2i(4, 2) and get_cell_source_id(layer, cellPos) == 1:
				var wall_R = wallTile.instantiate()
				wall_R.position = map_to_local(cellPos) * scale + Vector2(-12, 22) + Vector2(0, -40) * layer
				wall_R.z_index = layer
				wall_R.left = false
				add_child(wall_R)
				erase_cell(layer, cellPos)
			if get_cell_atlas_coords(layer, cellPos) == Vector2i(3, 3) and get_cell_source_id(layer, cellPos) == 1:
				var wall_L = wallTile.instantiate()
				wall_L.position = map_to_local(cellPos) * scale + Vector2(-12, 10) + Vector2(0, -40) * layer
				wall_L.z_index = layer
				wall_L.front_wall = true
				add_child(wall_L)
				erase_cell(layer, cellPos)
			if get_cell_atlas_coords(layer, cellPos) == Vector2i(4, 3) and get_cell_source_id(layer, cellPos) == 1:
				var wall_R = wallTile.instantiate()
				wall_R.position = map_to_local(cellPos) * scale + Vector2(12, 10) + Vector2(0, -40) * layer
				wall_R.z_index = layer
				wall_R.left = false
				wall_R.front_wall = true
				add_child(wall_R)
				erase_cell(layer, cellPos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	hide_front_walls()
	pass


#func hide_front_walls():
#	for layer in range(1, get_layers_count()):
#		for cellPos in get_used_cells(layer):
#			if get_cell_source_id(layer, cellPos) == 1 and get_cell_tile_data(layer, cellPos).front_wall == true:
#				if local_to_map(get_parent().get_node("player").global_position).x < 1:
#					pass
		
