extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.game = self
	Global.gameTime = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Global.mousePos = get_global_mouse_position()
	Global.gameTime += delta
