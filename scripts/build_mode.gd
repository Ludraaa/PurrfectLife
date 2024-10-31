extends Panel

var moving : bool = false
var maxDistance : int = Constants.buildShopDistance
var currentDistance : int = 0
var speed : int = Constants.buildShopSpeed
var direction : bool = false

#var currentTab : Enums.BUILDMODETAB = Enums.BUILDMODETAB.FLOOR
var floorArray : Array = []
var floorTypeCount : int = 17

var wallArray : Array = []
var wallTypeCount : int = 0

var shopRows = 4
var shopLines = 7

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.buildShop = self
	Global.currBuildShopTab = Enums.BUILDMODETAB.FLOOR
	getFloors()
	getWalls()
	displayTabs()
	handleTabColor()
	
	if !direction:
		$BuildModeButton.tooltip_text = "Opens the building menu"
	else:
		$BuildModeButton.tooltip_text = "Closes the building menu"

func getFloors():
	for i in floorTypeCount:
		floorArray.append(Constants.floorResPath + str(i + 1) + ".tres")

func getWalls():
	for i in wallTypeCount:
		floorArray.append(Constants.wallResPath + str(i + 1) + ".tres")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handleOpenAndClose(delta)
	

func handleOpenAndClose(delta):
	if moving:
		if direction and currentDistance >= maxDistance:
			position.x -= speed * delta
			currentDistance -= speed * delta
		elif !direction and currentDistance <= 0:
			position.x += speed * delta
			currentDistance += speed * delta
		elif currentDistance == maxDistance:
			moving = false
		elif currentDistance == 0:
			moving = false

func displayTabs():
	match(Global.currBuildShopTab):
		Enums.BUILDMODETAB.FLOOR:
			var counter = 0
			for line in range(1, shopLines + 1):
				for row in range(1, shopRows + 1):
					var shopLine = %BuildShop.get_node("ShopColumn").get_node("ShopLine" + str(line))
					if (counter < floorTypeCount):
						if !shopLine.has_node(str(row)):
							var slot = Global.itemSlot.instantiate()
							slot.slotContent = load(floorArray[counter])
							slot.name = str(row)
							shopLine.add_child(slot)
						else:
							shopLine.get_node(str(row)).slotContent = load(floorArray[counter])
					elif shopLine.has_node(str(row)):
						shopLine.get_node(str(row)).queue_free()
					counter += 1
		Enums.BUILDMODETAB.WALL:
			#TO BE IMPLEMENTED
			#DELETES ALL ITEM SLOTS AS THERE ARE NO WALLS FOR NOW
			var counter = 0
			for line in range(1, shopLines + 1):
				for row in range(1, shopRows + 1):
					var shopLine = %BuildShop.get_node("ShopColumn").get_node("ShopLine" + str(line))
					if (counter < wallTypeCount):
						if !shopLine.has_node(str(row)):
							var slot = Global.itemSlot.instantiate()
							slot.slotContent = load(wallArray[counter])
							slot.name = str(row)
							shopLine.add_child(slot)
						else:
							shopLine.get_node(str(row)).slotContent = load(wallArray[counter])
					elif shopLine.has_node(str(row)):
						shopLine.get_node(str(row)).queue_free()
					counter += 1

func handleTabColor():
	var toBeColored
	var toBeDecolored = []
	match (Global.currBuildShopTab):
		Enums.BUILDMODETAB.FLOOR:
			toBeColored = get_node("FloorTab")
			toBeDecolored.append(get_node("WallTab"))
		Enums.BUILDMODETAB.WALL:
			toBeColored = get_node("WallTab")
			toBeDecolored.append(get_node("FloorTab"))

	var styleBox: StyleBoxFlat = toBeColored.get_theme_stylebox("panel").duplicate()
	styleBox.bg_color = Constants.shopTabSelectedColor
	styleBox.set_border_width_all(4)
	toBeColored.add_theme_stylebox_override("panel", styleBox)
	
	for tab in toBeDecolored:
		var box: StyleBoxFlat = tab.get_theme_stylebox("panel").duplicate()
		box.bg_color = Constants.shopTabColor
		box.set_border_width_all(1)
		tab.add_theme_stylebox_override("panel", box)

func deselectSlots(selected : int):
	var slotCount
	match (Global.currBuildShopTab):
		Enums.BUILDMODETAB.FLOOR:
			slotCount = floorTypeCount
		Enums.BUILDMODETAB.WALL:
			slotCount = wallTypeCount
	
	var counter = 0
	for line in range(1, shopLines + 1):
		for row in range(1, shopRows + 1):
			var shopLine = %BuildShop.get_node("ShopColumn").get_node("ShopLine" + str(line))
			if counter < slotCount:
				if counter != selected - 1:
					shopLine.get_node(str(row)).deselect()
			counter += 1


func _on_build_mode_button_toggled(toggled_on: bool) -> void:
	direction = !direction
	moving = true
	$BuildModeButton.modulate = Constants.baseColor
	if !direction:
		$BuildModeButton.tooltip_text = "Opens the building menu"
	else:
		$BuildModeButton.tooltip_text = "Closes the building menu"


func _on_floor_tab_button_pressed() -> void:
	Global.currBuildShopTab = Enums.BUILDMODETAB.FLOOR
	displayTabs()
	handleTabColor()


func _on_wall_tab_button_pressed() -> void:
	Global.currBuildShopTab = Enums.BUILDMODETAB.WALL 
	displayTabs()
	handleTabColor()
