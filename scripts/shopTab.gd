extends PanelContainer

var hovered : bool = false

func highlight():
	if hovered:
		self_modulate = Constants.highlightColor
	else:
		self_modulate = Constants.baseColor

func _on_mouse_entered() -> void:
	hovered = true
	highlight()


func _on_mouse_exited() -> void:
	hovered = false
	highlight()
