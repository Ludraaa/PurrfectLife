extends AnimatedSprite2D

@export var hovered_over : bool = false
@export var left : bool = true
@export var front_wall: bool = false

const typeArray = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
@export var type_index = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play(typeArray[type_index], 0)

func change_type(type : int):
	type_index = type
	play(typeArray[type_index], 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if left:
		$hitbox_area_wall/collisionL.disabled = false
		$hitbox_area_wall/collisionR.disabled = true
		set_frame_and_progress(0, 0)
	else:
		$hitbox_area_wall/collisionL.disabled = true
		$hitbox_area_wall/collisionR.disabled = false
		set_frame_and_progress(1, 0)

func _on_hitbox_area_wall_mouse_entered() -> void:
	set_modulate(Color(1.1, 1.2, 1.1, 1))
	hovered_over = true


func _on_hitbox_area_wall_mouse_exited() -> void:
	set_modulate(Color(1, 1, 1, 1))
	hovered_over = false
