extends PanelContainer

@export var slotContent : floorData

var hovered : bool = false
var selected : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	display()

func display():
	if slotContent:
		tooltip_text = slotContent.name
		%Price.text = str(slotContent.price)
		%Texture.texture = slotContent.texture
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_mouse_entered() -> void:
	hovered = true
	onHover()
func _on_mouse_exited() -> void:
	hovered = false
	onHover()
	
func onHover():
	if hovered:
		modulate = Constants.highlightColor
	else:
		
		modulate = Constants.baseColor
		
func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == false:
			selected = !selected
			var styleBox: StyleBoxFlat = get_theme_stylebox("panel").duplicate()
			if selected:
				styleBox.bg_color = Constants.shopSlotHighlightColor
				styleBox.set_border_width_all(4)
			else:
				styleBox.bg_color = Constants.shopSlotColor
				styleBox.set_border_width_all(0)
			add_theme_stylebox_override("panel", styleBox)
			
			Global.tileMap.placeFloor(slotContent.id - 1)
			Global.tileMap.hovering = false
			Global.buildShop.deselectSlots(slotContent.id)

func deselect():
	var styleBox: StyleBoxFlat = get_theme_stylebox("panel").duplicate()
	styleBox.bg_color = Constants.shopSlotColor
	styleBox.set_border_width_all(0)
	add_theme_stylebox_override("panel", styleBox)
	selected = false
