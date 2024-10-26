extends CharacterBody2D

@export var pathTarget : Node2D

var speed = 3000

@onready var navigationAgent = $Navigation/NavigationAgent2D


func _physics_process(delta):
	if pathTarget:
		if pathTarget.global_position == global_position:
			pathTarget = null
		else:
			var direction = Vector2.ZERO
			direction = (navigationAgent.get_next_path_position() - global_position).normalized()
			velocity.x = direction.x * speed * delta
			velocity.y = direction.y * speed * delta * 0.5
			
			move_and_slide()
	


func _on_timer_timeout():
	if pathTarget:
		navigationAgent.target_position = pathTarget.global_position + Vector2(0, -25)
