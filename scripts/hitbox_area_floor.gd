extends Area2D

@onready var game = get_parent().get_parent().get_parent()
@onready var player = game.get_node("player")

@export var hovered_over : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$highlight_box.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("lmb") and hovered_over:
		player.pathTarget = self
		player.get_node("Navigation/NavigationAgent2D").target_position = global_position + Vector2(0, -25)


func _on_mouse_entered():
	get_parent().set_modulate(Color(1.1, 1.2, 1.1, 1))
	hovered_over = true


func _on_mouse_exited():
	get_parent().set_modulate(Color(1, 1, 1, 1))
	hovered_over = false
	
