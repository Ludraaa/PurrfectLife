extends Area2D

@onready var game = get_parent().get_parent().get_parent()
@onready var player = game.get_node("player")

# Called when the node enters the scene tree for the first time.
func _ready():
	$highlight_box.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("lmb") and $highlight_box.visible:
		player.pathTarget = self


func _on_mouse_entered():
	$highlight_box.visible = true


func _on_mouse_exited():
	$highlight_box.visible = false

