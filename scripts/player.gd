extends CharacterBody2D

var speed = Constants.playerMovementSpeed

func _physics_process(delta: float) -> void:
	handleMovement(delta)
	handleZoom(delta)
	

func handleMovement(delta: float):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("down"):
		direction += Vector2(0, 1)
	if Input.is_action_pressed("left"):
		direction += Vector2(-2, 0)
	if Input.is_action_pressed("up"):
		direction += Vector2(0, -1)
	if Input.is_action_pressed("right"):
		direction += Vector2(2, 0)
	direction = direction.normalized()
	velocity = speed * direction * delta
	move_and_slide()

func handleZoom(delta: float):
	if Input.is_action_just_pressed("zoom in"):
		$"Player Camera".zoom += Vector2(4, 4) * delta
	if Input.is_action_just_pressed("zoom out"):
		$"Player Camera".zoom -= Vector2(4, 4) * delta
