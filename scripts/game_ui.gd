extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handleTime(delta)
	
func handleTime(delta: float):
	var seconds = fmod(Global.gameTime, 60)
	var minutes = fmod(Global.gameTime, 3600) / 60
	%TimeSeconds.text = "%02d" % seconds
	%TimeMinutes.text = "%02d :" % minutes
