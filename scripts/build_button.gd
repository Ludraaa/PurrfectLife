extends TextureButton

var hovered : bool = false

func highlight():
	if hovered:
		if button_pressed:
			modulate = Constants.shopOpenHover
		else:
			modulate = Constants.shopCloseHover
	else:
		modulate = Constants.baseColor

func _on_mouse_entered() -> void:
	hovered = true
	highlight()


func _on_mouse_exited() -> void:
	hovered = false
	highlight()
